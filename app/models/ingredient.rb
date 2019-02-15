class Ingredient < ApplicationRecord
	belongs_to :measurement
	belongs_to :grocery
	belongs_to :recipe
	validates :recipe, {
		uniqueness: { scope: :grocery },
		presence: true
	}
	validates :grocery, {
		uniqueness: { scope: :recipe },
		presence: true
	}
	validates :measurement, {
		presence: true
	}
	validates :amount, { presence: true }
	validate :amount_validation

	def display_amount
		amount < 1 ? amount.to_r.to_s : amount.to_s
	end

	def display_ingredient_list
		"#{display_amount} #{measurement.abbreviation} #{grocery.grocery_name}"
	end

	private
	def amount_validation
		if !/\A\d*\/[1,2,3,4,8]\z/.match(amount.to_r.to_s)
			errors.add(:amount, 'must be a whole number or fraction with denominator 2,3,4 or 8')
		end
	end
end
