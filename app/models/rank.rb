class Rank < ActiveRecord::Base
	has_many :users

	validates :title, presence: true, length: { maximum: 12 }, uniqueness: { case_sensitive: false }
	VALID_HEX_REGEX = /#[A-F0-9]{6}/i
	validates :color, presence: true, format: { with: VALID_HEX_REGEX, message: " must be a Hexidecimal number." }
	validates :requirement, presence: true
	validates_numericality_of :requirement, greater_than_or_equal_to: 0
end