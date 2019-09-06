class RecievedRequestService
	def self.friend_received_request_ids(user)
		user.received_requests.select{|k| !k.accepted }.map{|var| var.requester_id }
	end

end