class CreateBusinessRules < ActiveRecord::Migration
  def change
    create_table :business_rules do |t|
      t.integer :store_id
      t.integer :booksmin, :default => 0
      t.integer :booksmax, :default => 0
      t.decimal :rule, :precision => 6, :scale => 2, :default => 0

      t.timestamps
    end
  end
end
