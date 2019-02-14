class Grocery < ApplicationRecord
	@grocery_types = ['Fruit','Vegetables','Meat','Poultry','Seafood','Bakery','Deli','Canned Goods','Dry Goods','Frozen Goods','Spices','Sauces','Drinks']
	
	validates :grocery_type, { 
		presence: true,
		inclusion: { in: @grocery_types }
	}
	validate :tougher_uniqueness_validation

	def self.grocery_types
		@grocery_types
	end

	private
	def tougher_uniqueness_validation
		too_similar = Grocery.where("UPPER(REPLACE(grocery_name,'\s','')) = UPPER(REPLACE(?,'\s',''))",grocery_name)
		if too_similar.any?	
			errors.add(:grocery_name, "#{too_similar.first.grocery_name} already exists")
		end
	end
end
