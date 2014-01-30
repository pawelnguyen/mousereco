# This migration comes from mousereco (originally 20140130215132)
class AddLimitToTimestamps < ActiveRecord::Migration
  def up
    #these probably should be stored as timestamp type, not integers. not refactoring yet
    change_column :mousereco_events, :timestamp, :integer, limit: 5
    change_column :mousereco_pageviews, :timestamp, :integer, limit: 5
  end

  def down
    change_column :mousereco_events, :timestamp, :integer
    change_column :mousereco_pageviews, :timestamp, :integer
  end
end
