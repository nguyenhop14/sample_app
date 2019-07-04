class User < ApplicationRecord
  before_save {email.downcase!}

  VALID_EMAIL_REGEX = Settings.user.emailRegex

  validates :name, presence: true, length: {maximum: Settings.user.maxName}
  validates :email, presence: true, length: {maximum: Settings.user.maxEmail},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.user.minPass}

  has_secure_password
end
