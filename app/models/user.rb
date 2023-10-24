class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  # 6.2.5演習No.2
  # before_save { self.email = email.downcase! }
  before_save   :downcase_email
  before_create :create_activation_digest
  # 6.2.4演習No.2
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  # 7.3.3演習No.1
  # validates :password, presence: true, length: { minimum: 5 }
  # validates :password, presence: true, length: { minimum: 6 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  # def User.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                 BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # 9.1.1演習No.2（リスト9.4）
  # def self.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                 BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # ランダムなトークンを返す
  # def User.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # 9.1.1演習No.2（リスト9.4）
  # def self.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # 9.1.1演習No.2（リスト9.5）
  # class << self
      # 渡された文字列のハッシュ値を返す
  #   def digest(string)
  #     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                   BCrypt::Engine.cost
  #     BCrypt::Password.create(string, cost: cost)
  #   end

      # ランダムなトークンを返す
  #   def new_token
  #     SecureRandom.urlsafe_base64
  #   end
  # end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    # 9.1.4演習No.2
    # return false if remember_digest.nil?
    # 9.1.4演習No.3
    # return false if remember_digest.nil?

    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効にする
  def activate
    update(activated: true)
    update(activated_at: Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    # self.email = email.downcase
    # 11.1.2演習No.3
    email.downcase!
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
