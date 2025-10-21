class Coupon < ApplicationRecord
  has_many :orders

  validates :code, presence: true, uniqueness: true
  validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :min_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :expires, presence: true

  def expired?
    Time.current > expires
  end
end
