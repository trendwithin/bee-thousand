class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  enum registration_status: { pending: 0, registered: 1, expired: 2 }
  enum role: { standard: 0, admin: 1 }


  has_many :microposts, dependent: :destroy
  has_many :likes
  has_many :alerts

  def admin?
    role == 'admin'
  end

  def registered?
    role = 'registered'
  end

  def likes?(micropost)
    micropost.likes.where(user_id: id).any?
  end

  def active_for_authentication?
    super && self.registration_status == 'registered'
  end


end
