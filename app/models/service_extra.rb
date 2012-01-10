class ServiceExtra < ActiveRecord::Base
  belongs_to :store
  has_many :offers
  has_many :resorts, :through => :offers
end
