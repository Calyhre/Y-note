class Contestation < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :user
  belongs_to :returner_exam

  time_as_boolean :deleted, opposite: :active

  validate :content, presence: true
end
