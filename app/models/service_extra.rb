class ServiceExtra < ActiveRecord::Base
  belongs_to :store
  has_many :offers
  has_many :resorts, :through => :offers
  has_many :extras
  has_many :books, :through => :extras
  scope :storeadmin, lambda { |value|
    stores = Store.where{admin_id.eq value}
    where{store_id.in(stores.select{id})}
  }
end

