class Content < ApplicationRecord
  belongs_to :lecture

  has_one_attached :video
  has_one_attached :pdf

  enum content_type: %i[text_img video pdf]
end
