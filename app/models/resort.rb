class Resort < ActiveRecord::Base
  belongs_to :store
  has_many :intervals
  has_many :books
  scope :store, lambda { |value| where(:store_id => value) }
end
