class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :upvoted_users, through: :likes, source: :user

  #default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :description, presence: true
  validates :link, presence: true

  after_save do 
    if pinned? 
      user.posts.where("id != ?", id).update_all(pinned: false)
    end
  end
end
