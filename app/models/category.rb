class Category < ActiveRecord::Base
  has_many :stores
  has_attached_file :icon, :styles => { :thumb => "16x16>" }, :path => ":rails_root/public/images/:filename", :url => "/images/:filename"
end
