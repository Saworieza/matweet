class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :name, :string
    add_column :users, :username, :string
  	add_column :users, :about, :string
  	add_column :users, :location, :string
  	add_column :users, :website, :string

    add_index :users, :username, unique: true
  end
end
