class Interval < ActiveRecord::Base
  belongs_to :resort
  has_many :books
  class << self
    def by_resort(value)
      books = Book.busy(Date.today, value)
      Interval.where{id.not_in(books.select{interval_id})}
    end
  end

end
