class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :resort_id
      t.integer :service_extra_id
      t.boolean :enable, :default => true
      t.boolean :hduration, :default => true
      t.boolean :hcost, :default => true

      t.timestamps
    end
  end
end
