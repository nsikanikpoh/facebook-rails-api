class Api::V1::CommentSerializer < Api::V1::ApplicationSerializer
  attributes :content, :user_id, :post_id
  belongs_to :user, serializer: Api::V1::UserSerializer
end
