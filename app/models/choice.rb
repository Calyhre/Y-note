class Choice < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :question

  time_as_boolean :deleted, opposite: :active

  validates :title, :position
end
