class Choice < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :question

  time_as_boolean :deleted, opposite: :active

  validates :title, presence: true

  scope :correct, -> { where('correct = ?', true) }
end
