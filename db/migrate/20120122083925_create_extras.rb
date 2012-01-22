class CreateExtras < ActiveRecord::Migration
  def change
    create_table :extras do |t|
      t.integer :book_id
      t.integer :service_extra_id

      t.timestamps
    end
  end
end
