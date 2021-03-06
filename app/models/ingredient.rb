class Ingredient < ApplicationRecord
	# associations
	belongs_to :measurement
	belongs_to :grocery
	belongs_to :recipe
	# validations
	validates :recipe, presence: { message: 'must be assigned' }
	validates :grocery, { 
		uniqueness: { scope: :recipe , message: 'is already an ingredient of this recipe' }, 
		presence: { message: 'must be assigned' }
	}
	validates :measurement, presence: { message: 'must be assigned' }
	validates :amount, numericality: { greater_than: 0 , message: 'must be a whole number or fraction with denominator 2,3,4 or 8' }
	validates :comment, length: { maximum: 100 }
	validate :common_amounts_only

	# display helpers
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
		measurement_override ? measurement_override.downcase : measurement.abbreviation
	end

	def display_comment
		comment > '' ? (', ' << comment) : ''
	end

	def display_ingredient_list
		"#{display_amount} #{display_measurement} #{grocery.grocery_name}#{display_comment}"
	end

	private
	# callbacks
	before_save do |ingredient|
		measurement_override = nil if measurement.measurement_name != "Pieces"
	end

	after_save do |ingredient|
		recipe.update_attribute(:updated_at, DateTime.now)
	end

	# custom validation
	def common_amounts_only
		if !/\A\d*\/[1,2,3,4,8]\z/.match(amount.to_r.to_s)
			errors.add(:amount, 'must be a whole number or fraction with denominator 2,3,4 or 8')
		end
	end
end
