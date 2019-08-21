class Api::V1::UserSerializer < Api::V1::ApplicationSerializer
  attributes  :id, :email, :first_name, :last_name, :requests_count, 
  :friends_ids, :friend_request_ids, :sent_request_ids
end
