class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :interval
  has_many :extras, :dependent => :destroy
  has_many :service_extras, :through => :extras
  attr_reader :extra_tokens
  cattr_accessor :init_date, :finish_date
  after_create :sum_lasting_of_service_extras
  scope :busy, lambda { |day, resort| where(:resort_id => resort, :day => day) }
  scope :total, lambda { |day, resort, user| where{(user_id.eq user) & (day.gteq Date.today) & (resort_id.eq resort)}}
  scope :hoy, where{day == Date.today}
  scope :tomorrow, where{day == (Date.today + 1.day)}
  scope :month, where(:day => Date.new(Date.today.year, Date.today.month, 1)..Date.today)
  scope :range, lambda { |init, finish| where(:day => init..finish) }
  scope :storeadmin, lambda { |value|
    joins{interval.resort.store}.where{stores.admin_id.eq value}
  }
  scope :by_resort, lambda { |value, dia|
    books = Book.where{day.eq dia}
    where{(id.not_in(books.select{interval_id})) & (resort_id.eq value)}
  }
  scope :next_days, where(:day => Date.today..(Date.today + 7.day))

  def sum_lasting_of_service_extras
    for element in self.service_extra_ids
      tiempo += element.lasting
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

