class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  validates :content, presence: true
  default_scope -> { order(created_at: :asc) }
  mount_uploader :image, ImageUploader
  scope :friends_posts, -> (current_user) { where('user_id IN (?) OR user_id = ?',
    current_user.friend_ids, current_user.id).order(:created_at) }
end
