class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :user_id
      t.integer :resort_id
      t.date :day
      t.integer :interval_id

      t.timestamps
    end
  end
end
