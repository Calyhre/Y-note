class Subject < ActiveRecord::Base
  include ActAsTimeAsBoolean
  acts_as_nested_set

  has_many :courses
  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active

  validate :title, presence: true
end
