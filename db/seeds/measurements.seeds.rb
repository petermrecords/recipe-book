require 'csv'

Measurement.destroy_all

CSV.foreach(Rails.root.join('lib','seeds','measurements.csv'), headers: true) do |row|
	Measurement.create(row.to_hash)
end