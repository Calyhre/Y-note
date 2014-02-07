class Period < ActiveRecord::Base
  include ActAsTimeAsBoolean
  acts_as_nested_set

  has_many :groups
  has_many :comments, as: :parent

  validate :title, :start_at, :end_at, presence: true

  time_as_boolean :deleted, opposite: :active
end
