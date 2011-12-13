class Resort < ActiveRecord::Base
  belongs_to :store
  scope :store, lambda { |value| where(:store_id => value) }
end
