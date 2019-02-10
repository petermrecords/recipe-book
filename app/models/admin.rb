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

	before_discard do
		if email == ENV['SUPER_ADMIN_EMAIL_ADDRESS']
			flash[:alert] = 'Cannot delete the super admin account.'
			redirect_to :back
		end
	end

	def full_name
		[first_name,last_name].join(' ')
	end
end
