require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  # Associations
  has_many :contacts, dependent: :destroy

  before_save { self.email = email.downcase }

  # Validations
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?
end