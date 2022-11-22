class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 3 }
  validates :email, uniqueness: { case_sensitive: false }
  before_save { email.downcase! }

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    email.downcase!
    email.strip!
    @user = User.find_by_email(email)

    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end
  
end
