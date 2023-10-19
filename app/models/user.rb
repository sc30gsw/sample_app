class User < ApplicationRecord
  # 6.2.5演習No.2
  # before_save { self.email = email.downcase! }
  before_save { self.email = email.downcase }
  # 6.2.4演習No.2
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  # 7.3.3演習No.1
  validates :password, presence: true, length: { minimum: 5 }
  # validates :password, presence: true, length: { minimum: 6 }
end
