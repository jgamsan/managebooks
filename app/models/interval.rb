class Interval < ActiveRecord::Base
  belongs_to :resort
  has_many :books
  #validate :exact_distribution_of_period
  cattr_reader :period, :time_init, :time_finish
  def to_label
    "#{init.strftime('%H:%M')}"
  end
  def intervalo
    "#{init.strftime('%H:%M')} - #{finish.strftime('%H:%M')}"
  end
  def exact_distribution_of_period
    inicio = Interval.columns_hash['time_init'].to_s.to_datetime
    fin = Interval.columns_hash['time_finish'].to_s.to_datetime
    #inicio = Time.new("time_init(1i)".to_i, "time_init(2i)".to_i, "time_init(3i)".to_i, "time_init(4i)".to_i, "time_init(5i)".to_i)
    #fin = Time.new("time_finish(1i)".to_i, "time_finish(2i)".to_i, "time_finish(3i)".to_i, "time_finish(4i)".to_i, "time_finish(5i)".to_i)
    if ((fin - inicio)%(period.to_i * 60)) > 0
      errors.add(:period, "Periodo Incorrecto. No es exacto en las horas elegidas")
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

