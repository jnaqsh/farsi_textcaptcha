class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :full_name

  validates_presence_of :email, :full_name
  validates_length_of :full_name, minimum: 3, maximum: 25
  validates :email, email_format: true

  scope :admins, where(admin: true)

  before_validation :generate_password, unless: :password

  acts_as_textcaptcha

  def send_api_key
    generate_token(:api_key)
    self.api_key_sent_at = Time.zone.now
    save!
    UserMailer.send_api_key(self.id).deliver
  end

  private
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64.downcase
    end while User.exists?(column => self[column])
  end

  def generate_password
    generate_token(:password_digest)
  end
end
