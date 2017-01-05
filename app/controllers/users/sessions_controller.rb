class Users::SessionsController < Devise::SessionsController

  def create
    super do |user|
      # Warum nochmal bei jedem Login? 
      # Weil sich sonst die Fakezeiten nicht ändern, wenn sich jemand einlogged.

      user.randomized_fposts.delete_all

      Fpost.all.each do |fp|
        user.randomized_fposts.new(fpost: fp)
      end

      # Fakeposts in der Zukunft
      # ACHTUNG funktioniert nicht in mySQL auf heroku! Da muss es RAND oder so heißen


      futurePosts = user.randomized_fposts.order("RANDOM()").limit(3) 
      i = 3

      user.save

      # 3 Fakeposts sollen in der Zukunft sein
      futurePosts.each do |fp|
        fp.update_attribute(:fake_time, Time.now + i.minutes) # ACHTUNG: + 1.hour macht, dass die drei Posts alle ganz oben stehen!!!

        if user.group == 2 || user.group == 3
          i = i * 3
        else 
          i = i * 9
        end
      end
    end
  end
end
