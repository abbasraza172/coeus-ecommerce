class Feedback < ApplicationRecord
    belongs_to :reviewable, polymorphic: true
end
