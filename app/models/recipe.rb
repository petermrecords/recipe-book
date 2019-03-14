class Recipe < ApplicationRecord
	# roles - constant list
	RECIPE_ROLES = ['Small Bite','Beverage','Meat','Poultry','Seafood','Vegetable','Side Dish','Dessert']
	# associations
	belongs_to :author, class_name: 'Admin', foreign_key: :admin_id
	has_many :ingredients, dependent: :destroy
	has_many :groceries, through: :ingredients
	has_many :steps, dependent: :destroy
	# validations
	validates :dish_name, { presence: { message: 'cannot be blank' } , uniqueness: true }
	validates :author, presence: { message: 'cannot be blank' }
	validates :serves, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12, message: 'must be a number between 1 and 12' }
	validates :dish_role, inclusion: { in: self::RECIPE_ROLES , message: 'must be assigned a recognized role' }

	validates :ingredients, presence: { message: 'must have at least one ingredient', on: :publish }
	validates :steps, presence: { message: 'must have at least one step in its directions', on: :publish }
	# scopes
	scope :published, -> { where("published_at IS NOT NULL") }
	scope :unpublished, -> { where("published_at IS NULL") }

	# prep time helpers
	def total_prep_time_in_seconds
		steps.map { |s| s.prep_time_in_seconds }.inject(:+)
	end

	def active_prep_time_in_seconds
		steps.active.map { |s| s.prep_time_in_seconds }.inject(:+)
	end

	def display_total_prep_time
		if total_prep_time_in_seconds > 3600
			"#{total_prep_time_in_seconds/3600} hours #{(total_prep_time_in_seconds.to_f/60.0).ceil} minutes"
		else
			"#{(total_prep_time_in_seconds.to_f/60.0).ceil} minutes"
		end
	end

	def display_active_prep_time
		if !active_prep_time_in_seconds
			"None"
		elsif active_prep_time_in_seconds > 3600
			"#{active_prep_time_in_seconds/3600} hours #{(active_prep_time_in_seconds.to_f/60.0).ceil} minutes"
		else
			"#{(active_prep_time_in_seconds.to_f/60.0).ceil} minutes"
		end
	end

	# role helper for icons
	def dish_role_as_icon
		case dish_role
		when 'Small Bite'
			'hotdog'
		when 'Beverage'
			'cocktail'
		when 'Meat'
			'hippo'
		when 'Poultry'
			'drumstick-bite'
		when 'Seafood'
			'fish'
		when 'Vegetable'
			'carrot'
		when 'Side Dish'
			'mortar-pestle'
		when 'Dessert'
			'cookie-bite'
		end
	end

	def published?
		!!published_at
	end

	# step order helpers
	def next_step_index
		steps.count + 1
	end

	def reindex_steps(added_index)
		index_counter = 1
		steps.order(step_order: :asc, updated_at: :desc).each do |step|
			index_counter += 1 if step.step_order == added_index
			if step.step_order != index_counter
				step.update_attribute(step_order: index_counter)
			end
			index_counter += 1
		end
	end
end
