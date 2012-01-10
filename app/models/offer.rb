class Offer < ActiveRecord::Base
  belongs_to :resort
  belongs_to :service_extra
end
