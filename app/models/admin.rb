class Admin < ApplicationRecord
	has_secure_password
	include Discard::Model

	validates :first_name, { presence: true }
	validates :last_name, { presence: true }
	validates :email, { presence: true, uniqueness: true }
end
