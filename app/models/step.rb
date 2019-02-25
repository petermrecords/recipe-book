class Step < ApplicationRecord
  validates :recipe, { presence: true }
  validates :step_order, { presence: true, numericality: { greater_than_or_equal_to: 1 } }
  validates :prep_time, { presence: true }
  validates :is_active, { inclusion: { in: [true, false] } }
  validates :instruction, { presence: true }
  
  belongs_to :recipe
end
