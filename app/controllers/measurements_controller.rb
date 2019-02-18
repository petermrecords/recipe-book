class MeasurementsController < ApplicationController
	def selectbox
		@measurement_types = Measurement.measurement_types
		@measurement_type = params[:measurement_type]
		@measurements = Measurement.where(measurement_type: @measurement_type).order(:measurement_type, :measurement_name).pluck(:measurement_name, :id)
		respond_to do |format|
			format.js
		end
	end
end
