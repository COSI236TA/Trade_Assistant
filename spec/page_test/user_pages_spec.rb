require '../spec_helper'

describe "User pages" do

  subject { page }

  describe "how to register" do

    before {visit register_path}

    let(:submit) { "Create User" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
  end

  describe "signup" do
    before {visit register_path}  
    let(:submit) { "Create User" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

     describe "with valid information" do
       before do
         fill_in "user[email]",        with: "user2@example.com"
         fill_in "user[password]",     with: "foobar"
         fill_in "user[password_confirmation]", with: "foobar"
       end

       it "should create a user" do
         expect { click_button submit }.to change(User, :count).by(1)
       end
      end
  end

  describe "login" do
    before {visit login_path}

     describe "page with valid information" do
         it { should have_content("Please Log In") }
     end

      describe "with invalid user information" do
        before do
          fill_in "email", with: "ddsa@hotmail.com"
          fill_in "password", with: "aaaaa"
          click_button "Login"
        end
        it{ should have_link('Login', href: login_path) }
        it{ should have_link('Register', href: register_path) }

      end 


      describe "with valid user information" do
        before do
          @user = FactoryGirl.build(:user)
          #@user.skip_confirmation!
          @user.save!
          fill_in "email", with: @user.email
          fill_in "password", with: @user.password
          click_button "Login"
          #save_and_open_page
        end
        
        describe "and check links" do
          it{ should have_link('Log Out', href: logout_path) }
          it{ should have_content("ed@hotmail.com") }
          it{ should have_button("Create New Rule")}
        end

        describe "and check new rule" do
          before do
          click_button "Create New Rule"
          end
          it{ should have_content("New Rule") }
          it{ should have_button("Hit me")}

        end


      end
  end  

end