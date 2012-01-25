class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :interval
  has_many :extras
  has_many :service_extras, :through => :extras
  attr_reader :extra_tokens
  cattr_accessor :init_date, :finish_date
  scope :busy, lambda { |day, resort| where(:resort_id => resort, :day => day) }
  scope :total, lambda { |day, resort, user| where{(user_id.eq user) & (day.gteq Date.today) & (resort_id.eq resort)}}
  scope :hoy, where{day == Date.today}
  scope :tomorrow, where{day == (Date.today + 1.day)}
  scope :month, where(:day => Date.new(Date.today.year, Date.today.month, 1)..Date.today)
  scope :range, lambda { |init, finish| where(:day => init..finish) }
  def self.next_days
    Book.where(:day => Date.today..(Date.today + 7.day))
  end


  class << self
    def by_resort(value, dia)
      books = Book.where{day.eq dia}
      Interval.where{(id.not_in(books.select{interval_id})) & (resort_id.eq value)}
    end

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

