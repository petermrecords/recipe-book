class Grocery < ApplicationRecord
	@grocery_types = ['Fruit','Vegetables','Meat','Poultry','Seafood','Bakery','Dairy','Canned Goods','Dry Goods','Frozen Goods','Seasonings','Fats & Oils','Liquids']
	# associations
	has_many :ingredients
	# validations
	validates :grocery_type, { 
		presence: true,
		inclusion: { in: @grocery_types }
	}
	validates :grocery_name, { presence: true }
	validate :name_uniqueness_validation
	# type helper
	def self.grocery_types
		@grocery_types
	end

	private
	# custom validations
	def name_uniqueness_validation
		too_similar = Grocery.where("UPPER(REPLACE(grocery_name,'\s','')) = UPPER(REPLACE(?,'\s',''))",grocery_name)
		if too_similar.any?	
			errors.add(:grocery_name, "too similar to #{too_similar.first.grocery_name}")
		end
	end
end
