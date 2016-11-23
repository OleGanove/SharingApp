class Post < ApplicationRecord
  belongs_to :user
  #default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :description, presence: true
  validates :link, presence: true
  validate :only_one_pinned_post_per_user

  scope :pinned,  -> { where(pinned: true) }
  # bedeutet, dass er den neu erstellten Post nicht mitzählt in meiner Methode.
  scope :without, ->(id) { where.not(id: id) if id }

  private

  def only_one_pinned_post_per_user
    if pinned? && user.posts.pinned.without(id).any?
      errors.add(:pinned, 'Ein anderer Post ist schon angepinnt. Du kannst leider nur einen Post anpinnen.')
    end
  end
end
