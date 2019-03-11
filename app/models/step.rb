class Step < ApplicationRecord
	# associations
	belongs_to :recipe
	# validations
  validates :recipe, presence: { message: 'must be assigned' }
  validates :step_order, numericality: { greater_than_or_equal_to: 1, message: 'must be a positive number whole number' }
  validates :prep_time, format: { with: /(\A\d+ (hours|minutes|seconds)\z|\A\d\d:\d\d:\d\d\z)/, message: 'must be a positive whole number' }
  validates :is_active, inclusion: { in: [true, false], message: 'must be assigned a value' }
  validates :instruction, presence: { message: 'cannot be blank' }
  # scopes
  scope :active, -> { where(is_active: true) }

  # prep time helpers
  def parsed_prep_time
    if /\A(\d+) (hours|minutes|seconds)\z/.match(prep_time)
      parser = /\A(\d+) (hours|minutes|seconds)\z/.match(prep_time)
      {
        value: parser[1].to_i,
        units: parser[2]
      }
    elsif /\A(\d\d):(\d\d):(\d\d)\z/.match(prep_time)
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
    else
      nil
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

  after_save do |step|
    recipe.update_attribute(updated_at: DateTime.now)
  end
end
