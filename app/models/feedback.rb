class Feedback < ApplicationRecord
    # belongs to association
    belongs_to :reviewable, polymorphic: true
end
