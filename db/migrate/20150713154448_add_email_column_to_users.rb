class AddEmailColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string, null: :false, unique: true
  end
end
