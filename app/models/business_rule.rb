class BusinessRule < ActiveRecord::Base
  belongs_to :store
  scope :choose_rule, lambda { |value|
   where{(booksmin.lteq value) & (booksmax.gteq value)}
  }
  scope :by_store, lambda { |value| 
    where(:store_id => value)
  }
end
