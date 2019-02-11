class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
    	t.string :dish_name, null: false
    	t.text :description
    	t.integer :serves
    	t.references :admin, null: false
      t.timestamps null: false
    end
    add_index :recipes, :dish_name, unique: true
  end
end
