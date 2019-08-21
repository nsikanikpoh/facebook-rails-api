class FriendsService
	def self.friends_ids(user)
		user.friends.each.with_object([]){|var, arr| arr << var.otheruser_id }.uniq
	end
end