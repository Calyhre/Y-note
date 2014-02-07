class Answer < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :returned_exam
  belongs_to :question

  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active

  validate :answer, presence: true
end
