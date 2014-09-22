class Rank < ActiveRecord::Base
	include Comparable

	has_many :users

	validates :title, presence: true, length: { maximum: 12 }, uniqueness: { case_sensitive: false }
	VALID_HEX_REGEX = /#[A-F0-9]{6}/i
	validates :color, presence: true, format: { with: VALID_HEX_REGEX, message: "must be a Hexidecimal number." }
	validates :requirement, presence: true, uniqueness: { scope: :system, message: "must be unique." },
	  if: Proc.new { |a| !a.system }
	validates_numericality_of :requirement, greater_than_or_equal_to: 0

	def <=>(rank)
		if self.requirement < rank.requirement
			-1
		elsif self.requirement > rank.requirement
			1
		else
			0
		end
	end

	# Return the css styling for moderators
	def self.moderator_style
		mod = Rank.find(2)
		"color: #{mod.color};"
	end

end