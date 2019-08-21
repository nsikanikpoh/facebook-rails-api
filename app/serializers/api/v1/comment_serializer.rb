class Api::V1::CommentSerializer < Api::V1::ApplicationSerializer
  attributes :id, :content, :user_id, :post_id, :user_full_name
end
