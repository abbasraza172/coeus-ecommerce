class Picture < ApplicationRecord
  #belongs to and polymorphic association
  belongs_to :imageable, polymorphic: true
end
