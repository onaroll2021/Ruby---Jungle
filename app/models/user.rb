class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  before_save :clean_email

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    email.downcase!
    email.strip!
    user = User.find_by_email(email)
    user ? user.authenticate(password)? user : nil : nil
  end
  
  def clean_email
    self.email.downcase!
    self.email.strip!
  end
end
