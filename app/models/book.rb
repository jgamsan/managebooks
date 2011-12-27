class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :interval
  scope :busy, lambda { |day, resort| where(:resort_id => resort, :day => day) }
  scope :total, lambda { |day, resort, user| where{(user_id == user) & (day >= Date.today) & (resort_id == resort)}}

  def self.next_days
    Book.where(:day => Date.today..(Date.today + 7.day))
  end

  class << self
    def by_resort(value, dia)
      books = Book.where{day == dia}
      Interval.where{(id.not_in(books.select{interval_id})) & (resort_id == value)}
    end

    def weekly(value, day)
      books = Book.busy(day, value)
      Interval.where{(id.not_in(books.select{interval_id})) & (resort_id == value)}
    end

    def by_user(usuario)
      @user = User.find_by_uid(usuario)
      @user.books.where(:user_id => @user.id, :day => "=> #{Date.today}")
    end


  end

end
