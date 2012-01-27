class Resort < ActiveRecord::Base
  belongs_to :store
  has_many :intervals
  has_many :offers
  has_many :service_extras, :through => :offers
  scope :store, lambda { |value| where(:store_id => value) }

  class << self
    def by_storeadmin(role, user)
      if role == 1
        Resort.all
      else
        stores = Store.where{admin_id.eq user}
        Resort.where{store_id.in(stores.select{id})}
      end
    end
  end

end

