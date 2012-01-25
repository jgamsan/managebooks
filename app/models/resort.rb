class Resort < ActiveRecord::Base
  belongs_to :store
  has_many :intervals
  has_many :offers
  has_many :service_extras, :through => :offers
  scope :store, lambda { |value| where(:store_id => value) }

  class << self
    def by_storeadmin(user)
      stores = Store.where{admin_user_id == user}
      Resort.where{store_id.in(stores.select{id})}
    end
    def by_role(role)
      if role == 1
        Store.all
      else
        Store.where{admin_id.eq role}
      end
    end
  end

end

