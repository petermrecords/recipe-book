class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
    	t.references :recipe, null: false
    	t.references :grocery, null: false
    	t.references :measurement, null: false
      t.timestamps null: false
    end
    add_index :ingredients, [:recipe_id, :grocery_id], unique: true, name: 'unique_ingredient_index'
  end
end
