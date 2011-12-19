class AddDatasToApplication < ActiveRecord::Migration
  def change
    file = "#{Rails.root}/db/pro_datas/provinces.csv"
    CSV.foreach(file, :col_sep =>';') do |row|
      Province.create(:name => row[0])
    end

    file = "#{Rails.root}/db/pro_datas/towns.csv"
    CSV.foreach(file, :col_sep =>';') do |row|
      Town.create(:province_id => row[0], :name => row[1])
    end
  end
end
