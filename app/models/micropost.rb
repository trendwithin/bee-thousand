class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes
  validates :user_id, presence: true
  validates :content, presence: true

  scope :by_most_recent, -> { order(created_at: :desc) }
  delegate :email, to: :user, prefix: true
end
