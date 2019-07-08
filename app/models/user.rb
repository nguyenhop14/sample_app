class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest

  scope :activated, where activated: FILL_IN

  VALID_EMAIL_REGEX = Settings.user.emailRegex

  validates :name, presence: true, length: {maximum: Settings.user.maxName}
  validates :email, presence: true, length: {maximum: Settings.user.maxEmail},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.user.minPass, allow_nil: true}

  has_secure_password
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update :remember_digest, nil
  end

  def activate
    update activated: FILL_IN, activated_at: FILL_IN
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private:
    def downcase_email
      email.downcase!
    end

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest activation_token
    end
end
