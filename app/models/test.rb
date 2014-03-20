class Test < ActiveRecord::Base
  include ActAsTimeAsBoolean

  # classic     = 0 -> 20
  # percentage  = 0% -> 100%
  # letter      = A+ -> F-
  # oeapdt      = http://en.wikipedia.org/wiki/Hogwarts#Grading_and_assessment
  GRADING_SCHEMES = %w( classic percentage letter oeapdt random )

  PENALTY_TYPES = %w( none hourly daily weekly )

  belongs_to :course
  has_many :questions
  has_many :returned_exams
  has_many :comments, as: :parent

  accepts_nested_attributes_for :questions, allow_destroy: true

  delegate :subject, to: :course, prefix: true

  time_as_boolean :deleted, opposite: :active

  validates :start_at, :end_at, :grading_scheme, :coefficient, :title, presence: true
  validates :grading_scheme, inclusion: { in: GRADING_SCHEMES }

  default_scope { order('end_at') }
  scope :started, ->{ where('start_at < ?', Time.current) }
  scope :editable, ->{ where('start_at > ?', Time.current) }

  def active?
    start_at < Time.current && end_at > Time.current
  end

  def editable?
    start_at > Time.current
  end
end
