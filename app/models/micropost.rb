class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc)} # Sap xep theo created_at
  validates :user_id, presence: true
  validates :content, presence: true , length: {maximum: 140}
  validates :image, content_type: { in:  %w[image/jpeg image/gif image/png], # Image Type Support
                                    message: "must be a valid image format" },
                    size: { less_than: 5.megabytes, # Set limit of image
                                    message: "should be less than 5MB" }


  # Returns a resized image for display.
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
