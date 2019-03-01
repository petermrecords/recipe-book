class Step < ApplicationRecord
	# associations
	belongs_to :recipe
	# validations
  validates :recipe, { presence: true }
  validates :step_order, { presence: true, numericality: { greater_than_or_equal_to: 1 } }
  validates :prep_time, { 
    presence: true,
    format: { with: /\A\d+ (hours|minutes|seconds)\z/ }
  }
  validates :is_active, { inclusion: { in: [true, false] } }
  validates :instruction, { presence: true }

  # prep time helpers
  def parsed_prep_time
  if /\A(\d+) (hours|minutes|seconds)\z/.match(prep_time)
    {
      value: 
    }
  else
    parser = /\A(\d\d):(\d\d):(\d\d)\z/.match(prep_time)
    if parser[1] != "00"
      {
        value: parser[1].to_i,
        units: 'hours'
      }
    elsif parser[2] != "00"
      {
        value: parser[2].to_i,
        units: 'minutes'
      }
    else
      {
        value: parser[3].to_i,
        units: 'seconds'
      }
    end
  end

  def display_prep_time
    parsed_prep_time.values.join(' ')
  end

  def prep_time_in_seconds
    case parsed_prep_time[:units]
    when 'hours'
      parsed_prep_time[:value] * 3600
    when 'minutes'
      parsed_prep_time[:value] * 60
    else 
      parsed_prep_time[:value]
    end
  end

  private
  # callbacks 
  before_validation do |step|
  	step.instruction = step.instruction.strip
  end
end
