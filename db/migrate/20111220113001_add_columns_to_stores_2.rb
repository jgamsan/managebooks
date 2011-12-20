class AddColumnsToStores2 < ActiveRecord::Migration
  def change
    add_column :stores, :latitude, :decimal
    add_column :stores, :longitude, :decimal
    add_column :stores, :gmaps, :boolean
  end
end
