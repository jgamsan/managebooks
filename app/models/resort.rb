class Resort < ActiveRecord::Base
  belongs_to :store
  has_many :intervals
  has_many :offers
  has_many :service_extras, :through => :offers
  scope :store, lambda { |value| where(:store_id => value) }
  scope :storeadmin, lambda { |value|
    stores = Store.where{admin_id.eq value}
    Resort.where{store_id.in(stores.select{id})}
  }

end

