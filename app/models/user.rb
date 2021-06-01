class User < ApplicationRecord
    has_many :pictures, as: :imageable
    has_many :feedbacks, as: :reviewable
    has_many :orders
    has_many :products

    enum role: {admin: 0, seller: 1, customer: 2}

    ACCESS_RIGHTS = {'admin' => [:admin, :seller, :customer],
    'seller' => [:seller, :customer], 'customer' => [:customer] }

     def has_access(right)
        User::ACCESS_RIGHTS[self.role].include?(right)
     end

end
