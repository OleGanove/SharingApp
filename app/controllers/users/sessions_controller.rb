class Users::SessionsController < Devise::SessionsController

  def create
    super do |user|

      # Like und view number resetten:
      Fpost.all.each do |fp|
        fp.fill_like_and_view_number
        fp.save!
      end

      # Warum nochmal bei jedem Login die joined Posts löschen und erstellen? 
      # Weil sich sonst die Fakezeiten nicht ändern, wenn sich jemand einlogged.
      user.randomized_fposts.delete_all

      Fpost.all.each do |fp|
        user.randomized_fposts.new(fpost: fp)
      end

      # Alle angepinnten Fakeposts auf false setzen
      Fpost.update_all(pinned: false, futurepost: false)

      # 9 zufällige Fakeposts auf true setzen
      pinnedPosts = Fpost.order("RANDOM()").limit(9)
      pinnedPosts.update_all(pinned: true) 

      # Fakeposts in der Zukunft
      # ACHTUNG funktioniert nicht in mySQL auf heroku! Da muss es RAND oder so heißen
      futurePosts = user.randomized_fposts.order("RANDOM()").limit(3) 
      i = 3

      user.save

      # 3 Fakeposts sollen in der Zukunft sein
      futurePosts.each do |fp|
        fp.update_attribute(:fake_time, Time.now + i.minutes) # ACHTUNG: + 1.hour macht, dass die drei Posts alle ganz oben stehen!!!

        # Setze views und likes auf 0
        @fakepost = Fpost.where(id: fp.fpost_id)
        @fakepost.update_all(lowviews: 0, highviews: 0, lowlikes: 0, highlikes: 0, futurepost: true)

        # Da ich nicht auf lowviews/highviews etc. zugreifen kann, brauche ich den Post an sich:
        if user.group == 2 || user.group == 3
          i = i * 3
        else 
          i = i * 9
        end
      end

      
    end
  end
end

