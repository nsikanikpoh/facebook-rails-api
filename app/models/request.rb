class Request < ApplicationRecord
  belongs_to :requester, class_name: 'User', foreign_key: :requester_id
  belongs_to :requestee, class_name: 'User', foreign_key: :requestee_id
  scope :get_request_confirm, -> (requester_id, requestee_id) { where('requester_id = ? AND requestee_id = ?',
    requester_id, requestee_id) }	
  def accept
    self.update_attributes(accepted: true)
     Request.create!(requester_id: self.requestee_id,
                    requestee_id: self.requester_id,
                    accepted: true)
  end
end
