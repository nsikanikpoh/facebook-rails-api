class Request < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'

  def accept
    self.update_attributes(accepted: true)
    Request.create!(requester_id: self.requestee_id,
                    requestee_id: self.requester_id,
                    accepted: true)
  end
end
