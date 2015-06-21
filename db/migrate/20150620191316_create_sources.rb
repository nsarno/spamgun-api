class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :list_url, null: false
      t.string :form_url, null: false

      # form fields
      t.string :form_name, null: false
      t.string :form_email, null: false
      t.string :form_phone, null: false, default: ''
      t.text :form_body, null: false
      t.boolean :form_cc, default: true

      t.timestamps null: false
    end
  end
end
