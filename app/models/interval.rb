class Interval < ActiveRecord::Base
  #include ActiveModel::Validations
  belongs_to :resort
  has_many :books

  cattr_accessor :period, :time_init, :time_finish
  #validates_with :time_init, :time_finish, :period, :interval_times => true
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
  class IntervalTimesValidator < ActiveModel::Validator
    def validate
      errors.add(:period, "No permite un distribucion exacta en el intervalo de tiempo marcado") unless check_times?
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

