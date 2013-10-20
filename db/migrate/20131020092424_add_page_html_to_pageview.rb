class AddPageHtmlToPageview < ActiveRecord::Migration
  def change
    add_column :pageviews, :page_html, :text
  end
end
