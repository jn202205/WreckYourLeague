module UserAuth
  extend ActiveSupport::Concern

  included do
    validates_presence_of :fname, :lname, :email, :zipcode, :session_token
    validates :email, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }
    after_initialize :ensure_session_token
    attr_reader :password
  end

  module ClassMethods
    def find_by_credentials(user_params)
      user = User.find_by_email(user_params[:email])
      user.try(:is_password?, user_params[:password]) ? user : nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
