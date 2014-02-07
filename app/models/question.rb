class Question < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :test
  has_many :choices
  has_many :answers
  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active

  validates :title, :question_type, :position, :max_points, presence: true
end
