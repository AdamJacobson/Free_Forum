class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic, :inverse_of => :posts

	self.per_page = 20

	validates :user, presence: true
	validates :topic, presence: true
	validates :content, presence: true

	# Return the page index of the topic the post is on
	def page
		index = self.topic.posts.index(self) + 1
		(index / Post.per_page.to_f).ceil
	end

	# Return the anchor for the post
	def anchor
		"post-#{self.id}"
	end

	def permalink
	end
end
