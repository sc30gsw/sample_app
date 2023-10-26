class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # 4.1.3演習No.1
  # validates :follower_id, presence: true
  # validates :followed_id, presence: true
end
