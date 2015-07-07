class AddSpamMaxToSources < ActiveRecord::Migration
  def change
    add_column :sources, :spam_max, :integer, null: false, default: 0
  end
end
