class AddWebsiteIdToPageview < ActiveRecord::Migration
  def change
    add_column :pageviews, :website_id, :integer
  end
end
