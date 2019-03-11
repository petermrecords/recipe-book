class Grocery < ApplicationRecord
	# types - constant list
	GROCERY_TYPES = ['Fruit','Vegetables','Meat','Poultry','Seafood','Bakery','Dairy','Canned Goods','Dry Goods','Frozen Goods','Seasonings','Fats & Oils','Liquids']
	# associations
	has_many :ingredients
	# validations
	validates :grocery_type, { 
		inclusion: { in: self::GROCERY_TYPES, message: 'must be assigned a recognized type' }
	}
	validates :grocery_name, presence: { message: 'cannot be blank' }
	validate :name_uniqueness_validation

	private
	# custom validations
	def name_uniqueness_validation
		too_similar = Grocery.where("UPPER(REPLACE(grocery_name,'\s','')) = UPPER(REPLACE(?,'\s',''))",grocery_name)
		if too_similar.any?	
			errors.add(:grocery_name, "too similar to #{too_similar.first.grocery_name}")
		end
	end
end
