class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  default_scope -> { order(created_at: :desc) }
  validates :user_id, uniqueness: { scope: :post_id }
  scope :post_user_like, -> (user_id, post_id) { where('user_id = ? AND post_id = ?',
    user_id, post_id) }

  def full_user
  	self.user
  end
end
