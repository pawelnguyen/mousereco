class CreateMouserecoVisitors < ActiveRecord::Migration
  def change
    create_table :mousereco_visitors do |t|
      t.string :key

      t.timestamps
    end
  end
end
