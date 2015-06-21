class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.references :source, index: true, null: false
      t.string :uid, null: false
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end

    add_index :ads, [:source_id, :uid], unique: true
  end
end
