class Question < ActiveRecord::Base
  include ActAsTimeAsBoolean

  QUESTION_TYPES = %w( choices text code )
  PENALTY_TYPES = %w( strict proportional )

  belongs_to :test
  has_many :choices, dependent: :destroy
  has_many :answers
  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active

  validates :title, :question_type, :max_points, presence: true
  validates :question_type, inclusion: { in: QUESTION_TYPES }

  accepts_nested_attributes_for :choices, allow_destroy: true

  scope :not_with_choices, -> { where('question_type != ?', 'choices') }

  def can_autocorrect?
    self.with_choices?
  end

  QUESTION_TYPES.each do |type|
    define_method "with_#{type}?" do
      self.question_type == type
    end
  end

  PENALTY_TYPES.each do |type|
    define_method "#{type}?" do
      self.penalty_type == type
    end
  end

end
