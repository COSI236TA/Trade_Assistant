class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  #validates :password, :confirmation => true 
  has_secure_password
end