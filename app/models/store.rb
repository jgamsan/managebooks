class Store < ActiveRecord::Base
  belongs_to :category
  has_many :resorts
  belongs_to :town
  belongs_to  :admin_user

  scope :last_stores, order('created_at asc').limit(5)
  scope :category, lambda { |value| where(:category_id => value) }
end
