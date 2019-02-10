class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
    	t.string :first_name, null: false
    	t.string :last_name, null: false
    	t.string :email, null: false
    	t.string :password_digest, null: false
    	t.datetime :discarded_at
      t.timestamps null: false
    end
    add_index :admins, :email, unique: true
  end
end
