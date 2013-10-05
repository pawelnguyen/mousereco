class ChangeTimeoutType < ActiveRecord::Migration
  def change
    change_column :events, :timestamp, :bigint
  end
end
