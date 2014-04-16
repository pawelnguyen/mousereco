class CreateMouserecoVisits < ActiveRecord::Migration
  def change
    create_table :mousereco_visits do |t|

      t.timestamps
    end

    add_column :mousereco_pageviews, :visit_id, :integer
    add_index :mousereco_pageviews, :visit_id
  end
end
