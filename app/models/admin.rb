class Admin < ApplicationRecord
	has_secure_password
	include Discard::Model
	# associations
	has_many :recipes
	# validations
	validates :first_name, { presence: true }
	validates :last_name, { presence: true }
	validates :email, { 
		presence: true, 
		uniqueness: true,
		format: { with: /\A.+@.+\.\w*\z/, message: 'must be a valid email address' }
	}
	validates :password, { length: { minimum: 6 } }
	validate :password_contains_number_and_letter

	# display helper
	def full_name
		[first_name,last_name].join(' ')
	end

	# super admin helper
	def is_super_admin?
		!discarded? && email == ENV['SUPER_ADMIN_EMAIL_ADDRESS']
	end

	private
	# custom validation
	def password_contains_number_and_letter
		errors.add(:password, 'must contain a letter') if !/\A.*[A-Za-z].*\z/.match(password)
		errors.add(:password, 'must contain a number') if !/\A.*[0-9].*\z/.match(password)
	end
end
