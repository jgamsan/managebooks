class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :resort
  belongs_to :interval
  scope :busy, lambda { |day, resort| where(:resort_id => resort, :day => day) }
  scope :by_user, lambda { |user| where{(user_id == user) & (day >= Date.today)}}
  scope :total, lambda { |day, resort, user| where{(user_id == user) & (day >= Date.today) & (resort_id == resort)}}

  class << self
    def by_resort(value, day)
      books = Book.busy(day, value)
      Interval.where{(id.not_in(books.select{interval_id})) & (resort_id == value)}
    end

    def weekly(value, day)
      books = Book.busy(day, value)
      Interval.where{(id.not_in(books.select{interval_id})) & (resort_id == value)}
    end
  end

end
