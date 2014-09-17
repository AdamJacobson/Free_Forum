class User < ActiveRecord::Base
	has_many :topics
	has_many :posts
	belongs_to :rank
	
	has_secure_password

	before_save { email.downcase! }
	after_create :update_user_rank

	validates :username, presence: true, length: { maximum: 20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6, maximum: 72 }, allow_nil: true

	# Update user rank if applicable
	def update_user_rank

		if self.admin?
			self.rank = Rank.find(1)
			# elsif user.moderator?
				# user.rank = Rank.find(2)
			# end
		else
			self.rank = nil
			Rank.where(system: false).order('requirement ASC').each do |rank| 
				if self.posts.count >= rank.requirement
					self.rank = rank
				end
			end
		end

		self.save
	end

	# Return the css to style this user
	def rank_style
		if (self.rank.nil?)
			""
		else
			"color: #{self.rank.color};"
		end
	end

	# Returns the rank title for this user.
	# Should be used instead of user.rank.title as this checks for nil rank
	def rank_title
		if (self.rank.nil?)
			""
		else
			self.rank.title
		end
	end
end
