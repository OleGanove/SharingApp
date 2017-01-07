class Users::SessionsController < Devise::SessionsController

  def create
    super do |user|

      # Einträge der Fakeposts resetten
      Fpost.all.each do |fp|
        fp.fill_like_and_view_number
        fp.assign_attributes(pinned: false, futurepost: false)
        fp.save!
      end

      #pinnedPosts = Fpost.offset(rand(Fpost.count) - 9).limit(9) 
      pinnedPosts = Fpost.order("RANDOM()").limit(9)
      pinnedPosts.update_all(pinned: true) 


      # Randomisierten Fakeposts joined-Tabelle resetten
      user.randomized_fposts.delete_all

      Fpost.all.each do |fp|
        user.randomized_fposts.new(fpost: fp)
      end

      # Die angepinnten Posts multiplizieren

      user.set_group_belonging
      user.save

      if user.group == 0 || user.group == 1
        Fpost.where(pinned: true).each do |post|
          post.update_attributes( lowviews: 1 + post.lowviews * 5, 
                                  highviews: 1 + post.highviews * 3,
                                  lowlikes: 1 + post.lowlikes * 5,
                                  highlikes: 1 + post.highlikes * 3)
        end
      end

      #user.set_group_belonging
      #user.save

      # Fakeposts in der Zukunft
      # ACHTUNG funktioniert nicht in mySQL auf heroku! Da muss es RAND oder so heißen
      futurePosts = user.randomized_fposts.offset(rand(user.randomized_fposts.count) - 3).limit(3)

      i = 3

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

