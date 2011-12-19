class AddColumnsToStores < ActiveRecord::Migration
  def change
    add_column :stores, :address, :string
    add_column :stores, :zip_code, :string
    add_column :stores, :town_id, :integer
    add_column :stores, :phone, :string
    add_column :stores, :cellphone, :string
    add_column :stores, :email, :string
  end
end
