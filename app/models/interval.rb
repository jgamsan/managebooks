class Interval < ActiveRecord::Base
  belongs_to :resort
  has_many :books
  class << self

  end

end
