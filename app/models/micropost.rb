class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  # 13.3.5演習No.1 無効な送信
  # validates :content, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 140 }
end
