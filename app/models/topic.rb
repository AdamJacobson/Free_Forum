class Topic < ActiveRecord::Base
	belongs_to :user
	belongs_to :board
	has_many :posts

	self.per_page = 15

	validates :title, presence: true, length: { maximum: 255 }
	validates :user_id, presence: true
	validates :board_id, presence: true

	# Temporary holder for new topic content
	attr_accessor :content

	# Returns the last page index of the topic
	def last_page
		posts_num = self.posts.count
		if posts_num == 0
			1
		else
			(posts_num / Post.per_page.to_f).ceil
		end
	end
end
