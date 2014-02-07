class ReturnedExam < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :test
  belongs_to :user

  has_many :answers
  has_many :contestations

  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active
end
