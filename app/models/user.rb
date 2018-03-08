class User < ApplicationRecord

  # uses bcrypt-ruby to generate secure passwords
  has_secure_password

  # A user can create many tasks
  has_many :checklists

  # Email regex that every user email should adhere to
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # User model validation
  validates :first_name, presence: true, length: {maximum:20}
  validates :last_name, presence: true, length: {maximum: 20}
  validates :email, presence:true, length: {maximum: 200}, 
            format: {with: VALID_EMAIL}, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
end
