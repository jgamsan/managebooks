class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :interval
  has_many :extras, :dependent => :destroy
  has_many :service_extras, :through => :extras
  attr_reader :extra_tokens, :user_token
  cattr_accessor :init_date, :finish_date
  after_save :sum_lasting_of_service_extras
  #scope :busy, lambda { |day, resort| where(:resort_id => resort, :day => day) }
  scope :total, lambda { |day, resort, user| where{(user_id.eq user) & (day.gteq Date.today) & (resort_id.eq resort)}}
  scope :by_store, lambda { |value|
    joins{interval.resort.store}.where{stores.id.eq value}
  }
  scope :hoy, where{day == Date.today}
  scope :tomorrow, where{day == (Date.today + 1.day)}
  scope :month, where(:day => Date.new(Date.today.year, Date.today.month, 1)..Date.today)
  scope :monthly, where(:day => Date.new(Date.today.year, Date.today.month, 1)..Date.new(Date.today.year, Date.today.month, -1))
  scope :range, lambda { |init, finish| where(:day => init..finish) }
  scope :usuario, where{who =~ 'u%'}
  scope :storeadmin, lambda { |value|
    joins{interval.resort.store}.where{stores.admin_id.eq value}
  }
  scope :by_resort, lambda { |value|
    joins{interval}.select('count(books.id), intervals.resort_id, resorts.name, resorts.cost').monthly.usuario.by_store(value).group("intervals.resort_id, resorts.name, resorts.cost")
  }
  scope :in_resort, lambda {|value|
    joins{interval}.where{intervals.resort_id.eq value}
  }
  scope :next_days, where(:day => Date.today..(Date.today + 7.day))
  scope :between_login, lambda { |value|
    joins{interval.resort}.select('resorts.name, count(resorts.*) as total').where{created_at.gteq value}.group('resorts.name')
  }
  def user_token=(id)
    id.gsub!(/CREATE_(.+?)_END/) do
      nombre = $1.split('/')
      jd = Client.create!(:name => nombre[0], :phone => nombre[1]).id
      User.create!(:name => nombre[0], :uid => jd, :provider => "client").id
    end
    self.user_id = id
  end

  def por_telefono
    reserva = Book.find(id)
    salida = reserva.user.name.titleize
    if reserva.user.provider == "client"
      cliente = Client.find(reserva.user.uid)
      salida << " ("+ cliente.phone + ")"
    end
    salida
  end

  def sum_lasting_of_service_extras
    tiempo = 0
    unless self.service_extra_ids.nil?
      for element in self.service_extra_ids do
        extra = ServiceExtra.find(element.to_i)
        tiempo += extra.lasting
      end
    end
    interval = Interval.find(self.interval_id)
    final = interval.finish + tiempo.minutes
    @intervals = Interval.where{resort_id.eq interval.resort_id}
    unless tiempo == 0
      ocupados = []
      for i in (self.interval_id + 1)..(@intervals.size - 1)
        if @intervals[i].finish < tiempo
          final << i
        else
          break
        end
      end
      unless ocupados.empty?
        ocupados.each do |element|
          Book.create(:user_id => self.user_id, :day => self.day, :interval_id => element, :who => ("u" + self.user_id.to_s))
        end
      end
    end
  end

  class << self
    def weekly(value, day)
      books = Book.busy(day, value)
      Interval.where{(id.not_in(books.select{interval_id})) & (resort_id.eq value)}
    end


    def by_user(usuario)
      @user = User.find_by_uid(usuario)
      @user.books.where{day.gteq Date.today}
    end
  end

end

