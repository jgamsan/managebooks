class AddColumnToStores < ActiveRecord::Migration
  def change
    add_column :stores, :admin_user_id, :integer
  end
end
