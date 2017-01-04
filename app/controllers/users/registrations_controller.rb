class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      # Das ist nur wichtig, beim Erstellen der Profile
      # Sonst ist beim allerersten Login (direkt nach der Registrierung) alles leer. 
      # Kann aber auch weg.
      Fpost.all.each do |fp|
        resource.randomized_fposts.new(fpost: fp)
      end
    end
  end
end
