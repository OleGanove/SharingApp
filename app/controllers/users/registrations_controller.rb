class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      Fpost.all.each do |fp|
        resource.randomized_fposts.new(fpost: fp)
      end
    end
  end
end
