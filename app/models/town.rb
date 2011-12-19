class Town < ActiveRecord::Base
  belongs_to :province
  has_many :stores
end
