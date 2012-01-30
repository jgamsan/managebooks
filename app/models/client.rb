class Client < ActiveRecord::Base
  validates_uniqueness_of :phone
end
