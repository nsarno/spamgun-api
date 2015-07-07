class AddTitleToSources < ActiveRecord::Migration
  def change
    add_column :sources, :title, :string, null: false, default: 'No title'
  end
end
