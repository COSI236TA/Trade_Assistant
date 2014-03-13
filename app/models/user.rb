class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 20 }, format: { with: VALID_EMAIL_REGEX } 
  #validates :password, :confirmation => true 
  has_secure_password
end