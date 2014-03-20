class Test < ActiveRecord::Base
  include ActAsTimeAsBoolean

  # classic     = 0 -> 20
  # percentage  = 0% -> 100%
  # letter      = A+ -> F-
  # oeapdt      = http://en.wikipedia.org/wiki/Hogwarts#Grading_and_assessment
  GRADING_SCHEMES = %w( classic percentage letter oeapdt random )
  PENALTY_TYPES = %w( none hourly daily weekly )
  CORRECTION_STATE = %w( not_done ongoing done )

  belongs_to :course
  has_many :questions
  has_many :returned_exams
  has_many :comments, as: :parent

  accepts_nested_attributes_for :questions, allow_destroy: true

  delegate :subject, to: :course, prefix: true

  time_as_boolean :deleted, opposite: :active

  validates :start_at, :end_at, :grading_scheme, :coefficient, :title, presence: true
  validates :grading_scheme, inclusion: { in: GRADING_SCHEMES }

  after_save :delay_correction

  default_scope { order('end_at') }
  scope :started, ->{ where('start_at < ?', Time.current) }
  scope :editable, ->{ where('start_at > ?', Time.current) }
  scope :to_correct, ->{ where('correction_state = ?', 'not_done') }
  scope :being_corrected, ->{ where('correction_state = ?', 'ongoing') }
  scope :corrected, ->{ where('correction_state = ?', 'done') }

  def active?
    start_at < Time.current && end_at > Time.current
  end

  def editable?
    start_at > Time.current
  end

  def correctable?
    end_at < Time.current && correction_not_done?
  end

  def need_manual_correct?
    questions.not_with_choices.count > 0
  end

  GRADING_SCHEMES.each do |scheme|
    define_method "#{scheme}_grading_scheme?" do
      self.grading_scheme == scheme
    end
  end

  CORRECTION_STATE.each do |state|
    define_method "correction_#{state}!" do
      self.update_attribute :correction_state, state
    end
    define_method "correction_#{state}?" do
      self.correction_state == state
    end
  end

  private

  def delay_correction
    CorrectorWorker.perform_at self.end_at, self.id
  end

end
