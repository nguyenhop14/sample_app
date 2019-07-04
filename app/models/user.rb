class User < ApplicationRecord
  before_save {email.downcase!}

  VALID_EMAIL_REGEX = Settings.user.emailRegex

  validates :name, presence: true, length: {maximum: Settings.user.maxName}
  validates :email, presence: true, length: {maximum: Settings.user.maxEmail},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.user.minPass}

  has_secure_password
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end
end
