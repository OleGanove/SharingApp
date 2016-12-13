class Fpost < ApplicationRecord
  before_save :fill_like_number

  belongs_to :user, optional: true
  has_many :flikes, dependent: :destroy

  private 

  def fill_like_number
    low = rand(1..5)
    high = rand(20..25)

    self.assign_attributes(lowlikes: low, highlikes: high)
  end
end