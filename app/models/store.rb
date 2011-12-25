class Store < ActiveRecord::Base
  acts_as_gmappable

  belongs_to :category
  has_many :resorts
  belongs_to :town
  belongs_to  :admin_user

  scope :last_stores, order('created_at asc').limit(5)
  scope :category, lambda { |value| where(:category_id => value) }

  def gmaps4rails_infowindow
    unless self.id.nil?
      @town = Town.find(self.town_id) unless self.town_id.nil?
      @resorts = Resort.where(:store_id => self.id)
      info = ""
      info << self.address + "<br/>" unless self.address.nil?
      info << @town.name + "<br/>" unless @town.nil?
      info << "Reservas Disponibles:<br/>"
      @resorts.each do |resort|
        info << resort.name + ":" + resort.intervals.count.to_s + " Reservas disponibles<br/>"
      end
    end
    return info
  end
  def gmaps4rails_title
    "#{self.name}"
  end

  def gmaps4rails_address
    "#{self.address}, #{self.zip_code}"
  end

end

