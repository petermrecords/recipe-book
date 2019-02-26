class Measurement < ApplicationRecord
	# associations
	has_many :ingredients
	# type helper
	def self.measurement_types
		all.pluck(:measurement_type).uniq
	end
end
