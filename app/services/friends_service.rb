class FriendsService
	def self.friends_ids(user)
		user.friends.map{|var| var.otheruser_id }
	end
end