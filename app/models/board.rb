class Board < ActiveRecord::Base
	has_many :topics
	has_many :posts, :through => :topics

	validates :title, presence: true

	def rank
		if required_rank.nil?
			nil
		else
			Rank.find(self.required_rank)
		end
	end

end
