class Fpost < ApplicationRecord
  before_create :fill_like_and_view_number

  belongs_to :user, optional: true
  
  # Fakelikes - join table between user and fpost
  has_many :flikes, dependent: :destroy
  
  # Fakeviews
  has_many :fviews, dependent: :destroy

  # To randomized my post and give a specific timestamp for each user
  has_many :randomized_fposts, dependent: :destroy

  def fill_like_and_view_number
    lowlikes = rand(1..5)
    highlikes = rand(10..50)
    lowview = rand(20..30)
    highview = rand(200..300)

    self.assign_attributes(lowlikes: lowlikes, highlikes: highlikes, lowviews: lowview, highviews: highview)
  end
end
