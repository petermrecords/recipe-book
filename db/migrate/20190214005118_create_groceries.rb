class CreateGroceries < ActiveRecord::Migration[5.2]
  def change
    create_table :groceries do |t|
    	t.string :grocery_name, null: false
    	t.text :description
    	t.string :grocery_type, null: false
      t.timestamps null: false
    end
    add_index :groceries, :grocery_name, unique: true
  end
end
