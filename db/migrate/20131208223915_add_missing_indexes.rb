class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :events, :pageview_id
    add_index :pageviews, :visitor_id
    add_index :pageviews, :website_id
    add_index :websites, :user_id
  end
end
