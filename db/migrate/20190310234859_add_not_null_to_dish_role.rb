class AddNotNullToDishRole < ActiveRecord::Migration[5.2]
  def change
  	change_column :recipes, :dish_role, :string, null: false
  end
end
