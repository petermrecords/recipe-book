class CreateMeasurements < ActiveRecord::Migration[5.2]
  def change
    create_table :measurements do |t|
    	t.string :measurement_name, null: false
    	t.string :abbreviation
    	t.string :measurement_type, null: false
      t.timestamps null: false
    end
  end
end
