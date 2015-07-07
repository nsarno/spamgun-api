class AddHostnameToAds < ActiveRecord::Migration
  def up
    remove_index :ads, [:source_id, :uid]
    add_column :ads, :hostname, :string, null: false, default: ''
    add_index :ads, [:hostname, :uid], unique: true

    execute <<-SQL
      UPDATE ads
        SET hostname = substring(sources.list_url from '.*://([^/]*)')
        FROM sources
        WHERE sources.id = ads.source_id
    SQL
  end

  def down
    remove_index :ads, [:hostname, :uid]
    remove_column :ads, :hostname
    add_index :ads, [:source_id, :uid], unique: true
  end
end
