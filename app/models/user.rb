class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
			 :length => {:within => 5..25},
			 format: { with: VALID_EMAIL_REGEX } 
  has_many :rules
  has_secure_password
  validates :password, length: { minimum: 5}#, :confirmation => true
  
end
