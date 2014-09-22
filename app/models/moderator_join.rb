class ModeratorJoin < ActiveRecord::Base
	belongs_to :user
	belongs_to :board

  validates :user_id, presence: true
  validates :board_id, presence: true

  validates_uniqueness_of :user_id, scope: :board_id, message: "cannot moderate a board twice. That makes no sense."
end