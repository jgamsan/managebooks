class Interval < ActiveRecord::Base
  belongs_to :resort
  has_many :books

  cattr_accessor :period, :time_init, :time_finish
  scope :storeadmin, lambda { |value|
    @store = Store.find_by_admin_id(value)
    @resorts = @store.resorts.map {|x| x.id}
    where(:resort_id => @resorts)
  }
  def to_label
    "#{init.strftime('%H:%M')}"
  end
  def intervalo
    "#{init.strftime('%H:%M')} - #{finish.strftime('%H:%M')}"
  end

  def check_times?
    @inicio = Time.new(Date.today.year, Date.today.month, Date.today.day, time_init[0..1].to_i, time_init[3..4].to_i)
    @fin = Time.new(Date.today.year, Date.today.month, Date.today.day, time_finish[0..1].to_i, time_finish[3..4].to_i)
    if ((@fin - @inicio)%(period.to_i * 60)) > 0
      return false
    else
      return true
    end
  end


end

