class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic, :inverse_of => :posts

	self.per_page = 20

	validates :user, presence: true
	validates :topic, presence: true
	validates :content, presence: true

	after_create :update_topic_last_post_time
	after_save :update_topic_last_post_time, :update_user_rank

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
		"/topics/#{self.topic.id}?page=#{self.page}##{self.anchor}"
	end

	private

		def update_user_rank
			self.user.update_user_rank
		end

		def update_topic_last_post_time
			self.topic.update(last_replied_to_at: self.created_at)
		end
end
