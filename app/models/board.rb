class Board < ActiveRecord::Base
	has_many :topics

	self.per_page = 10
end
