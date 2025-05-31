class AddUsernameLastnameRole < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :lastname, :string, null: false
    add_column :users, :admin, :boolean, default: false, null: false
  end
end
