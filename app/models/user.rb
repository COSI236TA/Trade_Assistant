class User < ActiveRecord::Base
  has_many :rules
  validates :email, presence: true, uniqueness: true
  validates :password, :confirmation => true 
  has_secure_password
end