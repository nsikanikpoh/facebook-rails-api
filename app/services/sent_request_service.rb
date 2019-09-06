class SentRequestService
	def self.sent_request_ids(user)
		user.sent_requests.select{|k| !k.accepted }.map{|var| var.requestee_id }
	end
end