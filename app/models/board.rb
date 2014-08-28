class Board < ActiveRecord::Base
	has_many :topics
	has_many :posts, :through => :topics

	self.per_page = 10
end
