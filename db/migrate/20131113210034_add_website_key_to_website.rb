class AddWebsiteKeyToWebsite < ActiveRecord::Migration
  def change
    add_column :websites, :key, :string
  end
end
