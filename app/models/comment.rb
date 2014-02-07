class Comment < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :user
  belongs_to :parent, polymorphic: true

  time_as_boolean :deleted, opposite: :active

  validate :content, presence: true
end
