class Province < ActiveRecord::Base
  has_many :towns
end
