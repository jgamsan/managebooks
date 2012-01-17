class Interval < ActiveRecord::Base
  belongs_to :resort
  has_many :books

  cattr_reader :period, :time_init, :time_finish

  def to_label
    "#{init.strftime('%H:%M')}"
  end
  def intervalo
    "#{init.strftime('%H:%M')} - #{finish.strftime('%H:%M')}"
  end

  def self.check_times_between_period
    @inicio = Time.new(Date.today.year, Date.today.month, Date.today.day, self.time_init[0..1].to_i, self.time_init[3..4].to_i)
    @fin = Time.new(Date.today.year, Date.today.month, Date.today.day, self.time_finish[0..1].to_i, time_finish[3..4].to_i)
    if ((@fin - @inicio)%(period.to_i * 60)) > 0
      record.errors.add(:period, "Periodo Incorrecto. No es exacto en las horas elegidas")
    end
  end

  class << self
    def list_by_store_admin(user)
      @store = Store.find_by_admin_user_id(user)
      @resorts = @store.resorts.map {|x| x.id}
      Interval.where(:resort_id => @resorts).map {|x| x.id}.flatten
    end
  end

end

