class Group < ActiveRecord::Base
  include ActAsTimeAsBoolean
  acts_as_nested_set

  belongs_to :period
  has_and_belongs_to_many :users
  has_many :group_subjects
  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active

  validates :title, :role, presence: true
end
