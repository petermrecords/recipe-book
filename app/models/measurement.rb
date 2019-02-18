class Measurement < ApplicationRecord
	def self.measurement_types
		all.pluck(:measurement_type).uniq
	end
end
