class Bid < ActiveRecord::Base
  belongs_to :store
  mount_uploader :oferta, OfertaUploader
end

