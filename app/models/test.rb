class Test < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :course
  has_many :questions
  has_many :returned_exams
  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active

  validates :start_at, :end_at, :grading_scheme, :coefficient, :title, presence: true
end
