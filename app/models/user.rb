class User < ActiveRecord::Base

  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :purchases

  def library
    Rails.cache.fetch(["user_library_#{id}"], expires_in: 5.minutes) do
      purchases.alive
    end
  end

  def expire_library_cache
    Rails.cache.delete "user_library_#{id}"
  end

  def create_token
    random = SecureRandom.urlsafe_base64(nil, false)
    self.token = BCrypt::Password.create(random)
    self.save!
    random
  end

  def validate_token?(tok)
    BCrypt::Password.new(token) == tok
  end

end