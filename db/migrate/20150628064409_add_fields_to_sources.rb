class AddFieldsToSources < ActiveRecord::Migration
  def change
    add_column :sources, :page_param, :string, null: false, default: 'o'
    add_column :sources, :page_start, :integer, null: false, default: 1
    add_column :sources, :page_max, :integer, null: false, default: 1
  end
end
