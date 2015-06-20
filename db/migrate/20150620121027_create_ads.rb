class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :origin, null: false
      t.string :uid, null: false
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end

    add_index :ads, [:origin, :uid], unique: true
  end
end
