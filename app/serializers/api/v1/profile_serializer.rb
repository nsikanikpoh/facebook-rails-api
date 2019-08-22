class Api::V1::ProfileSerializer < Api::V1::ApplicationSerializer
  attributes :id, :birthday, :gender, :user_id, :location, :bio, :avatar, :cover,
  :user_full_name, :user_first_name, :user_friends
end
