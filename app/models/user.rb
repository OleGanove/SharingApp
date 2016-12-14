class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  after_create :set_group_belonging
  attr_accessor :login
  
  has_many :posts, dependent: :destroy

  # Liking real posts
  has_many :likes, dependent: :destroy
  has_many :upvoted_posts, through: :likes, source: :post

  # Pinning posts
  has_one :pinned_post, -> { where(pinned: true) }, class_name: "Post"
  
  # Liking fake posts
  has_many :fposts, dependent: :destroy
  has_many :flikes, dependent: :destroy
  has_many :upvoted_fposts, through: :flikes, source: :fpost

  # Randomized fake posts
  has_many :randomized_fposts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

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
end


