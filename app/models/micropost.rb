class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validate  :picture_size
  # 13.3.5演習No.1 無効な送信
  # validates :content, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 140 }

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
