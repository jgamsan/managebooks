class AddColumnToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :role, :integer
    add_column :admins, :first_name, :string
    add_column :admins, :last_name, :string
    add_column :admins, :status, :boolean, :default => false
  end
end
