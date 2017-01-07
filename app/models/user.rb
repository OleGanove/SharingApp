class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  after_create :set_group_belonging, :reset_fakeposts, :reset_randomized_fposts, :multiply_views_of_pinned_posts, :set_future_posts
  attr_accessor :login
  
  # User can create posts (but actually no fposts... egal)
  has_many :posts, dependent: :destroy
  has_many :fposts, dependent: :destroy

  # Pinning posts
  has_one :pinned_post, -> { where(pinned: true) }, class_name: "Post"
  
  # Liking real posts
  has_many :likes, dependent: :destroy
  has_many :upvoted_posts, through: :likes, source: :post

  # Liking fake posts

  has_many :flikes, dependent: :destroy
  has_many :upvoted_fposts, through: :flikes, source: :fpost

  # Viewing real posts
  has_many :views, dependent: :destroy
  has_many :viewed_posts, through: :views, source: :post

  # Viewving fake posts
  has_many :fviews, dependent: :destroy
  has_many :viewed_fposts, through: :fviews, source: :fpost

  # Randomized fake posts
  has_many :randomized_fposts, dependent: :destroy

  # Paperclip
  has_attached_file :avatar, styles: { medium: "200x200#", thumb: "50x50>" }, default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  # Validation
  validates :username, :presence => true,
                       :uniqueness => { :case_sensitive => false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true


  # Probanden in eine von vier Untersuchungsbedingungen einteilen
  def set_group_belonging
    group_number = self.id % 4
    self.update_attributes(group: group_number)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end  


  def reset_fakeposts
    Fpost.all.each do |fp|
      fp.fill_like_and_view_number
      fp.assign_attributes(pinned: false, futurepost: false)
      fp.save!
    end
      
    pinnedPosts = Fpost.order("RANDOM()").limit(9)  # ACHTUNG: Bei mySQL funktioniert nur RAND()
    pinnedPosts.update_all(pinned: true) 
  end



  def reset_randomized_fposts
    self.randomized_fposts.delete_all

    Fpost.all.each do |fp|
      self.randomized_fposts.create!(fpost: fp)
    end
  end


  def multiply_views_of_pinned_posts
      puts "Die Gruppe der neuen Person ist " + self.group.to_s

      if self.group == 0 || self.group == 1
        puts "Ich gehe hier rein. Jetzt ist die Gruppe: " + self.group.to_s
        Fpost.where(pinned: true).each do |post|
          post.update_attributes( lowviews: 1 + post.lowviews * 5, 
                                  highviews: 1 + post.highviews * 3,
                                  lowlikes: 1 + post.lowlikes * 5,
                                  highlikes: 1 + post.highlikes * 3)
        end
      end
  end


  def set_future_posts

      futurePosts = self.randomized_fposts.offset(rand(self.randomized_fposts.count)).limit(3) 

      i = 3

      # 3 Fakeposts sollen in der Zukunft sein
      futurePosts.each do |fp|
        fp.update_attribute(:fake_time, Time.now + i.minutes) # ACHTUNG: + 1.hour macht, dass die drei Posts alle ganz oben stehen!!!

        # Setze views und likes auf 0
        @fakepost = Fpost.where(id: fp.fpost_id)
        @fakepost.update_all(lowviews: 0, highviews: 0, lowlikes: 0, highlikes: 0, futurepost: true)

        # Da ich nicht auf lowviews/highviews etc. zugreifen kann, brauche ich den Post an sich:
        if self.group == 2 || self.group == 3
          i = i * 3
        else 
          i = i * 9
        end
      end
  end
end




