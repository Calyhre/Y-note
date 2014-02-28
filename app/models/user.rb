class User < ActiveRecord::Base
  include ActAsTimeAsBoolean
  include ActAsGendered
  act_as_gendered allow_nil: true

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups
  has_many :courses, foreign_key: :teacher_id
  has_many :tests, through: :groups
  has_many :returned_exams
  has_many :contestations
  has_many :comments
  has_many :comments, as: :parent

  validates :first_name, :last_name, :email, presence: true
  validate  :email, uniqueness: { case_sensitive: false }

  time_as_boolean :deleted, opposite: :active

  def roles
    @roles ||= self.groups.map &:role
  end

  def student?
    roles.include? 'student'
  end

  def full_name truncate: false
    if truncate
      [first_name, "#{last_name[0]}."].join ' '
    else
      [first_name, last_name].join ' '
    end
  end

  # To be replaced by DB field
  def avatar
    'default-avatar.png'
  end
end
