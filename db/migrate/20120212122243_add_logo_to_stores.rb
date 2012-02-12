class AddLogoToStores < ActiveRecord::Migration
  def change
    add_column :stores, :logo, :string
  end
end
