class RemoveColumnsFromCategories < ActiveRecord::Migration
  def up
    remove_columns :categories, :icon_file_name, :icon_content_type, :icon_file_size, :icon_updated_at
    add_column :categories, :icon, :string
  end

  def down
  end
end
