class Resort < ActiveRecord::Base
  belongs_to :store
  has_many :intervals
  scope :store, lambda { |value| where(:store_id => value) }
end
