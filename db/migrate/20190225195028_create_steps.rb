class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.references :recipe, null: false
      t.integer :step_order, null: false
      t.column :prep_time, :interval, null: false
      t.boolean :is_active, null: false
      t.text :instruction, null: false
      t.timestamps null: false
    end
  end
end
