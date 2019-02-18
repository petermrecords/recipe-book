class AddColumnsToIngredient < ActiveRecord::Migration[5.2]
  def change
  	add_column :ingredients, :measurement_override, :string
  	add_column :ingredients, :comment, :string
  end
end
