class CreateCalculatableVisits < ActiveRecord::Migration
  def change
    create_table :calculatable_visits do |t|

      t.timestamps
    end

    add_column :pageviews, :visit_id, :integer
    add_index :pageviews, :visit_id
  end
end
