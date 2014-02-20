class User < ActiveRecord::Base
  include ActAsTimeAsBoolean
  include ActAsGendered
  act_as_gendered allow_nil: true

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups
  has_many :subject_groups
  has_many :returned_exams
  has_many :contestations
  has_many :comments
  has_many :comments, as: :parent

  validates :first_name, :last_name, :email, presence: true
  validate  :email, uniqueness: { case_sensitive: false }

  time_as_boolean :deleted, opposite: :active
end
