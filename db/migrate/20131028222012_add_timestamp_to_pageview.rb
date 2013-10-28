class AddTimestampToPageview < ActiveRecord::Migration
  def change
    add_column :pageviews, :timestamp, :integer
  end
end
