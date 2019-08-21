class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  default_scope -> { order(created_at: :asc) }

  def user_full_name
  	"#{self.user.first_name} #{self.user.last_name}"
  end
end
