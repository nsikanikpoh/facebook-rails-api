class Api::V1::LikeSerializer < Api::V1::ApplicationSerializer
  attributes :user_id
  belongs_to :user, serializer: Api::V1::UserSerializer
end
