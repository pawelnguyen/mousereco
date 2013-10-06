class CreatePageviews < ActiveRecord::Migration
  def change
    create_table :pageviews do |t|
      t.string :url
      t.string :key
      t.integer :visitor_id

      t.timestamps
    end

    rename_column :visitors, :visitor_key, :key
    add_column :events, :pageview_id, :integer
    remove_column :events, :visitor_id
  end
end
