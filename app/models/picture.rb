class Picture < ApplicationRecord
  include ImageUploader::Attachment(:image)
  #belongs to and polymorphic association
  belongs_to :imageable, polymorphic: true

  
end
