class Interval < ActiveRecord::Base
  belongs_to :resort
  has_many :books

  scope :byresort, lambda { |value| where(:resort_id => value) }
end
