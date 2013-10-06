class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :visitor_key

      t.timestamps
    end

    add_column :events, :visitor_id, :integer
  end
end
