class Recipe < ApplicationRecord
	validates :dish_name, { presence: true, uniqueness: true }
	validates :author, { presence: true }
	validates :serves, { presence: true, numericality: {
		greater_than_or_equal_to: 1,
		less_than_or_equal_to: 12
	} }

	belongs_to :author, class_name: 'Admin', foreign_key: :admin_id
	has_many :ingredients
	has_many :groceries, through: :ingredients
	
end
