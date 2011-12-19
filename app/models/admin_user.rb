class AdminUser < ActiveRecord::Base

  enable_as_typus_user
  has_many :stores
end
