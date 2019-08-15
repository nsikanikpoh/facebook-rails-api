class Api::V1::PostSerializer < Api::V1::ApplicationSerializer
  attributes :content, :image, :user_id
  belongs_to :user, serializer: Api::V1::UserSerializer
  has_many :comments, serializer: Api::V1::CommentSerializer
  has_many :likes, serializer: Api::V1::LikeSerializer
end
