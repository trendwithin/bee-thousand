class Alert < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true, length: { maximum: 6 }
  validates :entry, presence: true, length: { maximum: 6 }
  validates :shares, length: { maximum: 6 }
  validates :stop, length: { maximum: 6 }
  validates :target, length: { maximum: 6 }
end
