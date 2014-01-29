# This migration comes from mousereco (originally 20140128001832)
class CreateMouserecoPageviews < ActiveRecord::Migration
  def change
    create_table :mousereco_pageviews do |t|
      t.string :url
      t.string :key
      t.integer :visitor_id
      t.text :page_html
      t.integer :window_width
      t.integer :window_height
      t.integer :timestamp

      t.timestamps
    end

    add_index :mousereco_pageviews, :visitor_id
  end
end
