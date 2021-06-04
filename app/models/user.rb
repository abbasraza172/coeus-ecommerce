class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #has many associations 
  has_many :pictures, as: :imageable
  has_many :feedbacks, as: :reviewable
  has_many :orders
  has_many :products

  enum role: {admin: 0, seller: 1, customer: 2}

  ACCESS_RIGHTS = {'admin' => [:admin, :seller, :customer],
  'seller' => [:seller, :customer], 'customer' => [:customer] }

  
  # Returns true if the role of user's instance has specific(given) right
  #
  # A specific right is sent as symbol in param.
  # It will check if the role of user's intance has 
  # access to the given right. It return false if it has no
  # access to specified right.
  def has_access(right)
    User::ACCESS_RIGHTS[self.role].include?(right)
  end
end
