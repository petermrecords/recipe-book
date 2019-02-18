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
	validates :comment, { length: { maximum: 100 } }
	validate :common_amounts_only

	before_save do |ingredient|
		measurement_override = nil if measurement.measurement_name != "Pieces"
	end

	def display_amount
		if amount < 1 
			amount.to_r.to_s
		elsif amount % 1 != 0
			[amount.to_i.to_s, (amount % 1).to_r.to_s].join(' ')
		else
			amount.to_i.to_s
		end
	end

	def display_measurement
		measurement_override ? measurement_override : measurement.abbreviation
	end

	def display_comment
		comment > '' ? (', ' << comment) : ''
	end

	def display_ingredient_list
		"#{display_amount} #{display_measurement} #{grocery.grocery_name}#{display_comment}"
	end

	private
	def common_amounts_only
		if !/\A\d*\/[1,2,3,4,8]\z/.match(amount.to_r.to_s)
			errors.add(:amount, 'must be a whole number or fraction with denominator 2,3,4 or 8')
		end
	end
end
