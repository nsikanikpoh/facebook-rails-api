class Api::V1::ProfileSerializer < Api::V1::ApplicationSerializer
  attributes :birthday, :gender, :location, :bio, :avatar, :cover
end
