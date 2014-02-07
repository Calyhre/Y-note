class GroupSubject < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :teacher, class_name: User
  belongs_to :group
  belongs_to :subject
  has_many :tests
  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active
end
