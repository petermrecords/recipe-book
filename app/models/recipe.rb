class Recipe < ApplicationRecord
	# associations
	belongs_to :author, class_name: 'Admin', foreign_key: :admin_id
	has_many :ingredients
	has_many :groceries, through: :ingredients
	has_many :steps
	# validations
	validates :dish_name, { presence: true, uniqueness: true }
	validates :author, { presence: true }
	validates :serves, { presence: true, numericality: {
		greater_than_or_equal_to: 1,
		less_than_or_equal_to: 12
	} }

	# step order-related helpers
	def next_step_index
		steps.count + 1
	end

	def reindex_steps(added_index)
		index_counter = 1
		steps.order(step_order: :asc, updated_at: :desc).each do |step|
			debugger
			index_counter += 1 if step.step_order == added_index
			step.step_order = index_counter
			index_counter += 1
			step.save
		end
	end

end
