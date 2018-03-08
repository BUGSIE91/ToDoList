class User < ApplicationRecord
  
  has_secure_password
  has_many :checklists

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true, length: {maximum:20}
  validates :last_name, presence: true, length: {maximum: 20}
  validates :email, presence:true, length: {maximum: 200}, 
            format: {with: VALID_EMAIL}, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
end
