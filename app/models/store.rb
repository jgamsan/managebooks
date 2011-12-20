class Store < ActiveRecord::Base
  acts_as_gmappable
  
  belongs_to :category
  has_many :resorts
  belongs_to :town
  belongs_to  :admin_user

  scope :last_stores, order('created_at asc').limit(5)
  scope :category, lambda { |value| where(:category_id => value) }

  def gmaps4rails_infowindow
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.town_id}"
  end
  def gmaps4rails_title
    "#{self.name}"
  end

  def gmaps4rails_address
    "#{self.address}, #{self.zip_code}"
  end

end
