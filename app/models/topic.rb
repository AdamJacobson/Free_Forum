class Topic < ActiveRecord::Base
	belongs_to :user
	belongs_to :board

	self.per_page = 15

	validates :title, presence: true, length: { maximum: 255 }
	validates :user_id, presence: true
	validates :board_id, presence: true

	# Temporary holder for new topic content
	attr_accessor :content
end
