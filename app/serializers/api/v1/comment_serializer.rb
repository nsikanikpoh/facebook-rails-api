class Api::V1::CommentSerializer < Api::V1::ApplicationSerializer
  attributes :content, :user_id, :post_id
end
