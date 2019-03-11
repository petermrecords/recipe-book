class AddDishRoleToRecipe < ActiveRecord::Migration[5.2]
  def change
  	add_column :recipes, :dish_role, :string
  	add_index :recipes, :dish_role
  end
end
