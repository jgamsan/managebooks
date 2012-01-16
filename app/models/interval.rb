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
  class << self
    def list_by_store_admin(user)
      @store = Store.find_by_admin_user_id(user)
      @resorts = @store.resorts.map {|x| x.id}
      Interval.where(:resort_id => @resorts).map {|x| x.id}.flatten
    end
  end

end

