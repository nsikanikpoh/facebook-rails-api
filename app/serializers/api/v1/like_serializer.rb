class Api::V1::LikeSerializer < Api::V1::ApplicationSerializer
  attributes :id, :user_id, :full_user
  belongs_to :user, serializer: Api::V1::UserSerializer
end
