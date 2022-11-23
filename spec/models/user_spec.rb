require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) {User.new(name: "Luke Li", email: "luke@gmail.com", password: '123456', password_confirmation: '123456')}
    it "is valid with valid attribute" do
      expect(user).to be_valid
    end 
    it "must be created with a password and password_confirmation fields" do
    user.password_confirmation = nil
    expect(user).to_not be_valid
    end
    it "should have password and password_confirmation field matching" do
    user.password_confirmation = '12345'
    expect(user.password).to_not eq(user.password_confirmation)
    expect(user).to_not be_valid
    end
    it "should have password and password_confirmation field matching" do
      expect(user.password).to eq(user.password_confirmation)
      expect(user).to be_valid
      end
    it "must have unique emails" do
      user.save
      expect(User.where(email: user.email).count).to be(1)
      @user2 = User.create(name: "Leo Li", email: "luke@gmail.com", password: '123465', password_confirmation: '123465')
      expect(User.where(email: user.email).count).not_to be(2)
    end
    it "emails can not be case sensitive" do
    user.save
    @user3 = User.create(name: "Ruan Zhe Yuan", email: "Luke@gmail.com", password: '123456', password_confirmation: '123456')
    expect(User.where(email: @user3.email).count).to be(0)
    end
    #password minimum length requirement
    it "must have a password minimum length of 6 characters" do 
      user.password = '12345'
      user.password_confirmation = '12345'
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    let(:user) {User.create(name: "Ruan Li", email: "ruan_li@gmail.com", password: '654321', password_confirmation: '654321')}

    it "should validate user" do
      @user = User.authenticate_with_credentials(user.email, user.password)
      expect(@user).not_to be_nil
    end
    it "should return nil if password does not match" do
      @user = User.authenticate_with_credentials(user.email, '654322')
      expect(@user).to be_nil
    end
    it "should return nil if user does not exist" do
      @user = User.authenticate_with_credentials('lil@gmail.com', user.password)
      expect(@user).to be_nil
    end
    it "should authenticate the user if there is space before or after the email" do
      @user = User.authenticate_with_credentials('  ruan_li@gmail.com  ', user.password)
      expect(@user).not_to be_nil
    end
    it "should authenticate the user if there is a wrong case in the email" do
      @user = User.authenticate_with_credentials('ruan_LI@gmail.com', user.password)
      expect(@user).not_to be_nil
    end
  end
end