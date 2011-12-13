class CreateIntervals < ActiveRecord::Migration
  def change
    create_table :intervals do |t|
      t.integer :resort_id
      t.time :init
      t.time :end

      t.timestamps
    end
  end
end
