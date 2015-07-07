class AddHostnameToAds < ActiveRecord::Migration
  def up
    remove_index :ads, [:source_id, :uid]
    add_column :ads, :hostname, :string, null: false, default: ''

    # Set hostname from sources.list_url
    execute <<-SQL
      UPDATE ads
        SET hostname = substring(sources.list_url from '.*://([^/]*)')
        FROM sources
        WHERE sources.id = ads.source_id
    SQL

    # Delete duplicates [:uid, :hostname]
    execute <<-SQL
      DELETE FROM ads WHERE id IN (
        SELECT id
        FROM (
          SELECT id, ROW_NUMBER() OVER (partition BY uid, hostname ORDER BY id) AS rnum
            FROM ads
        ) t 
        WHERE t.rnum > 1
      )
    SQL

    add_index :ads, [:hostname, :uid], unique: true
  end

  def down
    remove_index :ads, [:hostname, :uid]
    remove_column :ads, :hostname
    add_index :ads, [:source_id, :uid], unique: true
  end
end
