# We want 200 fake user


i = 1

200.times do
  group = i % 4

  User.create!({ :username => "mueller" + group.to_s + i.to_s, :email => "mueller" + group.to_s + i.to_s + "@cognition.uni-freiburg.de", :password => "passwort", :password_confirmation => "passwort"})
  i = i + 1
end

