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
	validates :password, {
		format: { with: /\A.*[A-Za-z].*\z/, message: 'must contain a letter' },
		format: { with: /\A.*[0-9].*\z/, message: 'must contain a number' },
		length: { minimum: 6 }
	}
	def full_name
		[first_name,last_name].join(' ')
	end
end
