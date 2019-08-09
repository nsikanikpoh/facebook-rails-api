class Api::V1::UserSerializer < Api::V1::ApplicationSerializer
  attributes  :id, :email, :first_name, :last_name
end
