class RenameColumnOfServiceExtras < ActiveRecord::Migration
  def up
    rename_column :service_extras, :resort_id, :store_id
  end

  def down
  end
end
