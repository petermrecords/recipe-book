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
	has_many :steps

	def reindex_steps
		recipe_steps = steps.order(step_order: :asc, modified: :desc)
		recipe_steps.each_with_index do |step, step_index|
			step.step_order = step_index + 1
		end
		recipe_steps.save
	end

end
