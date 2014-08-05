class Topic < ActiveRecord::Base
	belongs_to :user
	belongs_to :board

	validates :title, presence: true, length: { maximum: 255 }
	validates :user_id, presence: true
	validates :board_id, presence: true
end
