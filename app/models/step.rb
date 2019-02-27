class Step < ApplicationRecord
	# associations
	belongs_to :recipe
	# validations
  validates :recipe, { presence: true }
  validates :step_order, { presence: true, numericality: { greater_than_or_equal_to: 1 } }
  validates :prep_time, { presence: true }
  validates :is_active, { inclusion: { in: [true, false] } }
  validates :instruction, { presence: true }

  def prep_time_units
  end

  def prep_time_value
  end

  private
  # callbacks 
  before_validation do |step|
  	step.instruction = step.instruction.strip
  end
end
