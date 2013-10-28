class AddWindowSizesToPageview < ActiveRecord::Migration
  def change
    add_column :pageviews, :window_width, :integer, default: 0
    add_column :pageviews, :window_height, :integer, default: 0
  end
end
