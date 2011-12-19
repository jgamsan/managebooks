class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.integer :province_id
      t.string :name

      t.timestamps
    end
  end
end
