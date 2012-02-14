class Interval < ActiveRecord::Base
  belongs_to :resort
  has_many :books
  attr_accessor :period, :time_init, :numero
  scope :storeadmin, lambda { |value|
    @store = Store.find_by_admin_id(value)
    @resorts = @store.resorts.map {|x| x.id}
    where(:resort_id => @resorts)
  }
  scope :by_resort, lambda { |value, dia|
    books = Book.where{day.eq dia}
    where{(id.not_in(books.select{interval_id})) & (resort_id.eq value)}
  }
  scope :in_resort, lambda {|value|
    where{resort_id.eq value}
  }

  def to_label
    "#{init.strftime('%H:%M')}"
  end
  def intervalo
    "#{init.strftime('%H:%M')} - #{finish.strftime('%H:%M')}"
  end

  def self.for_select(value, dia)
    books = Book.where{day.eq dia}
    Resort.where(:store_id => value).map do |resort|
      [resort.name, resort.intervals.where{id.not_in(books.select{interval_id})}.map {|c| [c.intervalo, c.id]}]
    end
  end


end

