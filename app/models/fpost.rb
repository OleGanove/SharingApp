class Fpost < ApplicationRecord
  before_save :fill_like_and_view_number

  belongs_to :user, optional: true
  
  # Fakelikes - join table between user and fpost
  has_many :flikes, dependent: :destroy
  
  # Fakeviews
  has_many :fviews, dependent: :destroy

  # To randomized my post and give a specific timestamp for each user
  has_many :randomized_fposts, dependent: :destroy

  def fill_like_and_view_number
    low = rand(1..5)
    high = rand(20..25)
    lowview = rand(1..20)
    highview = rand(50..200)

    self.assign_attributes(lowlikes: low, highlikes: high, lowviews: lowview, highviews: highview)
  end
end
