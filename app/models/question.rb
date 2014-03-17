class Question < ActiveRecord::Base
  include ActAsTimeAsBoolean

  QUESTION_TYPES = %w( choices text code )
  PENALTY_TYPES = %w( all-in proportional )

  belongs_to :test
  has_many :choices
  has_many :answers
  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active

  validates :title, :question_type, :max_points, presence: true
  validates :question_type, inclusion: { in: QUESTION_TYPES }

  accepts_nested_attributes_for :choices
end
