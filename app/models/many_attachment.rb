class ManyAttachment < ApplicationRecord
  has_many_attached :image
end
