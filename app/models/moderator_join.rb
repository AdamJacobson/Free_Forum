class ModeratorJoin < ActiveRecord::Base
	belongs_to :user
	belongs_to :board

  validates :user_id, presence: true
  validates :board_id, presence: true
end