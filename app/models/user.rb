class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:3, maximum:25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum:105}, format: { with: VALID_EMAIL_REGEX }
  has_secure_password


  def self.from_omniauth(auth)
    #Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      user.user_name = auth.info.name
      user.email = auth.info.email
      if auth.info.uid
        user.uid = auth.info.uid
      end
      user.password = SecureRandom.hex
    end
  end
end
