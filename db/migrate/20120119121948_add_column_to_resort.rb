class AddColumnToResort < ActiveRecord::Migration
  def change
    add_column :resorts, :cost, :decimal, :precision => 6, :scale => 2, :default => 0
  end
end

