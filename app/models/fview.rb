class Fview < ApplicationRecord
  belongs_to :user
  belongs_to :fpost

  validates_uniqueness_of :fpost_id, scope: :user_id
end
