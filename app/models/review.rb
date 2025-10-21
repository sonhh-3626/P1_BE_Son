class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :rating, presence: true,
                     numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, length: { maximum: 1000 }

  after_save :update_product_rating
  after_destroy :update_product_rating

  private

  def update_product_rating
    product.update!(rating: product.reviews.average(:rating) || 0)
  end
end
