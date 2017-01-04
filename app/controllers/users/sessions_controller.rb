class Users::SessionsController < Devise::SessionsController

  def create
    super do |user|
      # Warum nochmal bei jedem Login? 
      # Weil sich sonst die Fakezeiten nicht ändern, wenn sich jemand einlogged.

      #allFposts = Fpost.all
      #seventyFposts = Fpost.order("RANDOM()").limit(70) # ACHTUNG: Bei mySQL heißt es: User.order("RAND()").limit(10)
      #rest = allFposts - seventyFposts

      user.randomized_fposts.delete_all

      # Fakeposts in der Vergangenheit
      Fpost.all.each do |fp|
        user.randomized_fposts.new(fpost: fp)
      end

      futurePosts = user.randomized_fposts.order("RANDOM()").limit(3)
      # Fakeposts in der Zukunft
      i = 1



      user.save

      futurePosts.each do |fp|
        fp.update_attribute(:fake_time, Time.now + 1.hour + i.minutes)
        i = i + 1
      end
   end
  end
end
