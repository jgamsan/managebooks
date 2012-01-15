class Category < ActiveRecord::Base
  has_many :stores
  mount_uploader :icon, IconUploader
end
