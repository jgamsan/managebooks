class Store < ActiveRecord::Base
  belongs_to :category
  has_many :resorts
end
