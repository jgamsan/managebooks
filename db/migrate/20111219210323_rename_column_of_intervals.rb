class RenameColumnOfIntervals < ActiveRecord::Migration
  def up
    rename_column :intervals, :end, :finish
  end

  def down
  end
end
