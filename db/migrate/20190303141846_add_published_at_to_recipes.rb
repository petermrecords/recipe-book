class AddPublishedAtToRecipes < ActiveRecord::Migration[5.2]
  def change
  	add_column :recipes, :published_at, :datetime
  	add_index :recipes, :published_at
  end
end
