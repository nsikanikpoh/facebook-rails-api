class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  validates :content, presence: true
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  scope :friends_posts, -> (user) { where('user_id IN (?) OR user_id = ?',
    user.friend_ids, user.id) }
end
