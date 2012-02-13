class CreateAdminBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :store_id
      t.string :name
      t.date :init
      t.date :finish

      t.timestamps
    end
  end
end

