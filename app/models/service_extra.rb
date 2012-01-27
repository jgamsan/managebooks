class ServiceExtra < ActiveRecord::Base
  belongs_to :store
  has_many :offers
  has_many :resorts, :through => :offers
  has_many :extras
  has_many :books, :through => :extras
  class << self
    def by_storeadmin(role, user)
      if role == 1
        Resort.all
      else
        stores = Store.where{admin_id.eq user}
        ServiceExtra.where{store_id.in(stores.select{id})}
      end
    end
  end
end

