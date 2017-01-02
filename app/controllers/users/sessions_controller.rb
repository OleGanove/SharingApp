class Users::SessionsController < Devise::SessionsController

  def create
    super do |user| 
      #user.randomized_fposts.delete_all
      #Fpost.all.each do |fp|
      #  resource.randomized_fposts.new(fpost: fp)
      #end
      #user.save
    end
  end
end
