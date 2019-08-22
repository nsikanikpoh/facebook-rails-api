class RecievedRequestService
	def self.friend_received_request_ids(user)
		user.received_requests.select{|k| !k.accepted }.each
		.with_object([]){|var, arr| arr << var.requester_id }.uniq
	end

end