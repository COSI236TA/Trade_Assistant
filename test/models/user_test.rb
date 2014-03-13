require '../test_helper'

class UserTest < ActiveSupport::TestCase

  # test "the truth" do
  #   assert true
  # end

  	def setup
  		@user = User.new(:email => 'test@example.com',:password => 'a',:password_confirmation=> 'a')
  	end

	def test_valid_user
		assert(@user.email != nil)
		assert(@user.password != nil)
		subject { @user }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
	end


end
