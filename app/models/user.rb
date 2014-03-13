class User < ActiveRecord::Base
<<<<<<< HEAD
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 20 }, format: { with: VALID_EMAIL_REGEX } 
=======
  has_many :rules
  validates :name, presence: true, uniqueness: true
>>>>>>> 98a65bcea191064a48045b1ce7d1bd5362be2b7a
  #validates :password, :confirmation => true 
  has_secure_password
end