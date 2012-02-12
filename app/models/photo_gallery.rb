class PhotoGallery < ActiveRecord::Base
  belongs_to :store
  mount_uploader :photo, PhotoUploader
  scope :storeadmin, lambda { |value|
    @store = Store.find_by_admin_id(value)
    where(:store_id => @store.id)
  }
end
