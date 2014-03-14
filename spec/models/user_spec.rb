require '..\spec_helper'

describe User do

  before { @user = User.new(:email => 'test@example.com',:password => 'a',:password_confirmation=> 'a') }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }


end