class RequestService
	def self.friend_request_ids(user)
		user.received_requests.select{|k| !k.accepted }.each
		.with_object([]){|var, arr| arr << var.requester_id }.uniq
	end

	def self.sent_request_ids(user)
		user.sent_requests.select{|k| !k.accepted }.each
		.with_object([]){|var, arr| arr << var.requestee_id }.uniq
	end

end