class BusinessRule < ActiveRecord::Base
  belongs_to :store
  paginates_per 7
  scope :choose_rule, lambda { |value|
   where{(booksmin.lteq value) & (booksmax.gteq value)}
  }
  scope :by_store, lambda { |value| 
    where(:store_id => value)
  }
end
