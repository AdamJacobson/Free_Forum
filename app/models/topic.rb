class Topic < ActiveRecord::Base
	belongs_to :user
	belongs_to :board
	has_many :posts, :inverse_of => :topic

	accepts_nested_attributes_for :posts

	self.per_page = 15

	validates :title, presence: true, length: { maximum: 255 }
	validates :user, presence: true
	validates :board, presence: true

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
