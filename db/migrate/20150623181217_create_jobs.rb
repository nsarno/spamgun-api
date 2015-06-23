class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.integer :status, null: false, default: 0
      t.references :source, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
