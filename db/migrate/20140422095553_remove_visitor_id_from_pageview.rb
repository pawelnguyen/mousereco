class RemoveVisitorIdFromPageview < ActiveRecord::Migration
  def up
    remove_column :mousereco_pageviews, :visitor_id
    add_column :mousereco_visits, :visitor_id, :integer
  end

  def down
    remove_column :mousereco_visits, :visitor_id
    add_column :mousereco_pageviews, :visitor_id, :integer
  end
end
