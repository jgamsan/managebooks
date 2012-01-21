class AddColumnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :who, :string
  end
end

