
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :uploads, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[a-z]{2,}\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX, message: "must be a valid email address" }

  validate :strong_password

  private

  def strong_password
    return if password.blank? # Devise handles presence
    unless password.match(/(?=.*[a-z])/) && password.match(/(?=.*[A-Z])/) && password.match(/(?=.*\d)/) && password.match(/(?=.*[^A-Za-z0-9])/)
      errors.add :password, "must include at least one uppercase letter, one lowercase letter, one digit, and one special character"
    end
    if password.length < 8
      errors.add :password, "must be at least 8 characters long"
    end
  end
end
