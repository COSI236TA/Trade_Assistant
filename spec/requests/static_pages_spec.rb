require '../spec_helper'

describe "User pages" do

  subject { page }

  describe "how to register" do

    before {visit '/register'}

    let(:submit) { "Create User" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
  end

	describe "with valid information" do

      before do
        fill_in "Email",        with: "user2@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end


end