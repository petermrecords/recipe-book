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
