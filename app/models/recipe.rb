class Recipe < ApplicationRecord
	validates :dish_name, { presence: true, uniqueness: true }
	validates :admin, { presence: true }

	belongs_to :author, class_name: 'Admin', foreign_key: :admin_id

end
