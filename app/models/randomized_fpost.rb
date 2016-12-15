class RandomizedFpost < ApplicationRecord
  belongs_to :user
  belongs_to :fpost

  before_save :set_fake_time

  private

  def random_time(from = 0.0, to = Time.now) 
    Time.at(from + rand * (to.to_f - from.to_f))
  end

  def set_fake_time
    self.assign_attributes(fake_time: random_time(10.days.ago))
  end
end


