class RandomizedFpost < ApplicationRecord
  belongs_to :user
  belongs_to :fpost

  after_create :set_fake_time

  private

  def random_time(from = 0.0, to = Time.now) 
    t = Time.at(from + rand * (to.to_f - from.to_f))

    while t.hour.between?(0, 7)
      t = Time.at(from + rand * (to.to_f - from.to_f))
    end

    return t
  end

  def set_fake_time
    # Wenn User mit group == 2 || User mit group == 3
    ## Dann setze die Zeiten viel kürzer (z.B. nur 5.days.ago)
    user = User.find_by(id: self.user_id)

    if user.group == 2 || user.group == 3
      self.update_attributes(fake_time: random_time(5.days.ago))
    else
      self.update_attributes(fake_time: random_time(10.days.ago))
    end

  end
end


