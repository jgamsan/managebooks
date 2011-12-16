class RemoveColumnInBooks < ActiveRecord::Migration
  def up
    remove_column :books, :resort_id
  end

  def down
  end
end
