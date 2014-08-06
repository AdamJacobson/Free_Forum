class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic

	self.per_page = 20

	validates :user_id, presence: true
	validates :topic_id, presence: true
	validates :content, presence: true, length: { minimum: 8 }
end
