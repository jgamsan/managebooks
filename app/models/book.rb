class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :resort
  belongs_to :interval
  scope :busy, lambda { |day, resort| where(:resort_id => resort, :day => day) }
  scope :by_user, lambda { |user| where{(user_id == user) & (day >= Date.today)}}
end
