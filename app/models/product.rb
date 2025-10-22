class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :order_items
  has_many :orders, through: :order_items

  enum :product_type, {
    cool_sale: 0,
    hot_deal: 1,
    new_arrival: 2,
  }

  validates :name, :price, :stock_quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  def discounted_price
    price * (1 - discount_percentage.to_f / 100)
  end

  def on_sale?
    discount_percentage > 0
  end

  def image_urls
    product_images.map(&:image_url)
  end

  def review_count
    reviews.count
  end

  alias_method :imageUrls, :image_urls
  alias_method :reviewCount, :review_count
end
