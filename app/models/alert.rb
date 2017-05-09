class Alert < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true, length: { maximum: 6 }
  validates :entry, presence: true, length: { maximum: 6 }
  validates :stop, presence: true, length: { maximum: 6 }
  validates :target, presence: true, length: { maximum: 6 }
  validates :shares, presence: true, length: { maximum: 6 }


end
