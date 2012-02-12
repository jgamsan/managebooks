class Store < ActiveRecord::Base
  acts_as_gmappable
  has_many :service_extras
  belongs_to :category
  has_many :resorts
  has_many :business_rules
  has_many :photo_galleries
  mount_uploader :logo, LogoUploader
  accepts_nested_attributes_for :resorts, :reject_if => :all_blank, :allow_destroy => true
  belongs_to :town
  belongs_to  :admin
  cattr_accessor :province
  scope :last_stores, order('created_at asc').limit(5)
  scope :category, lambda { |value| where(:category_id => value) }
  scope :admin, lambda { |value| where(:admin_user_id => value) }
  scope :storeadmin, lambda { |value|
    where{admin_id.eq value}
  }

  def self.infowindow(tienda)
    @store = Store.find(tienda)
    @resorts = @store.resorts
    info = ""
    info << @store.address + "<br/>" unless @store.address.nil?
    info << @store.town.name + "<br/>" unless @store.town_id.nil?
    info << "Reservas Disponibles:<br/>"
    @resorts.each do |resort|
      info << resort.name + ":" + resort.intervals.count.to_s + " Reservas disponibles<br/>"
    end
    return info
  end

  def gmaps4rails_sidebar
  "<span>#{name}</span>"
end

  def gmaps4rails_address
    "#{self.address}, #{self.zip_code}"
  end


  class << self
    def free_resorts
      parahoy = Book.where{day.eq Date.today}
      Interval.joins{resort.store}.select{'DISTINCT ON(stores.id) stores.*'}.where{id.not_in(parahoy.select{interval_id})}
    end

    def free_resorts_by_category(category)
      parahoy = Book.where{day.eq Date.today}
      Interval.joins{resort.store}.select{'DISTINCT ON(stores.id) stores.*'}.where{(id.not_in(parahoy.select{interval_id})) & (stores.category_id.eq category)}
    end
  end

end

