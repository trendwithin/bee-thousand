class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true

  scope :by_most_recent, -> { order(created_at: :desc) }
end
