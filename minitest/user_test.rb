require 'minitest/spec'
require 'minitest/autorun'

	describe User do 

		before do
			@user = User.new(:email => 'test@example.com',:password => 'a',:password_confirmation=> 'a')
		end

		it "check valid user" do

			assert(@user.email != nill)

		end


	end

