class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.references :source, null: false, index: true, foreign_key: true
      t.string :uid, null: false
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end

    add_index :ads, [:source_id, :uid], unique: true
  end
end
