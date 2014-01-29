class CreateMouserecoEvents < ActiveRecord::Migration
  def change
    create_table :mousereco_events do |t|
      t.float :x
      t.float :y
      t.integer :timestamp
      t.integer :pageview_id
      t.string :type

      t.timestamps
    end
    add_index :mousereco_events, :pageview_id
  end
end
