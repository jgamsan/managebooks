class RenameColumnInStores < ActiveRecord::Migration
  def up
    rename_column :stores, :admin_user_id, :admin_id
  end

  def down
  end
end
