class User < ActiveRecord::Base
	has_secure_password

	before_save { email.downcase! }

	validates :username, presence: true, length: { maximum: 20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6, maximum: 72 }

	# Validate a single attribute
	def self.valid_attribute?(attr, value)
		mock = self.new(attr => value)
		if mock.valid?
			true
		else
			!mock.errors.has_key?(attr)
		end
	end
end
