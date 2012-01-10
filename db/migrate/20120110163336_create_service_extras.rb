class CreateServiceExtras < ActiveRecord::Migration
  def change
    create_table :service_extras do |t|
      t.string :name
      t.integer :lasting, :default => 0
      t.decimal :cost, :precision => 6, :scale => 2, :default => 0
      t.integer :resort_id
      t.timestamps
    end
  end
end
