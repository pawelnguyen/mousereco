class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.float :x
      t.float :y
      t.integer :timestamp

      t.timestamps
    end
  end
end
