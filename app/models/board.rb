class Board < ActiveRecord::Base
	has_many :topics
	has_many :posts, :through => :topics

	has_many :moderator_joins
	has_many :moderators, through: :moderator_joins, source: :user

	validates :title, presence: true

	def rank
		if required_rank.nil?
			nil
		else
			Rank.find(self.required_rank)
		end
	end

	# Return true if the specified user is a moderator of this board
	def moderator?(user)
		self.moderators.include?(user)
	end


end
