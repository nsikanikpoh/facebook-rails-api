class SentRequestService
	def self.sent_request_ids(user)
		user.sent_requests.select{|k| !k.accepted }.each
		.with_object([]){|var, arr| arr << var.requestee_id }.uniq
	end

end