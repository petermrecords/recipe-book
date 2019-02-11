class Admin < ApplicationRecord
	has_secure_password
	include Discard::Model

	validates :first_name, { presence: true }
	validates :last_name, { presence: true }
	validates :email, { 
		presence: true, 
		uniqueness: true,
		format: { with: /\A.+@.+\.\w*\z/, message: 'must be a valid email address' }
	}
	validates :password, { length: { minimum: 6 } }
	validate :password_contains_number_and_letter

	has_many :recipes

	def full_name
		[first_name,last_name].join(' ')
	end

	def is_super_admin?
		email == ENV['SUPER_ADMIN_EMAIL_ADDRESS']
	end

	def password_contains_number_and_letter
		errors.add(:password, 'must contain a letter') if !/\A.*[A-Za-z].*\z/.match(password)
		errors.add(:password, 'must contain a number') if !/\A.*[0-9].*\z/.match(password)
	end
end
