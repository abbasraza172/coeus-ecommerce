class Feedback < ApplicationRecord
  # belongs to association
  belongs_to :reviewable, polymorphic: true

  #validations
  validates :stars, presence: true
  validates :stars, length: { in: 1..5 }
end
