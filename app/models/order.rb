class Order < ApplicationRecord
  belongs_to :user
  belongs_to :coupon, optional: true

  has_many :order_items, dependent: :destroy
  has_one :billing_detail, dependent: :destroy

  accepts_nested_attributes_for :billing_detail

  validates :subtotal, :final_total, numericality: { greater_than_or_equal_to: 0 }

  before_validation :calculate_totals

  def calculate_totals
    self.subtotal = order_items.sum { |item| item.price * item.quantity }
    if coupon && !coupon.expired?
      self.applied_discount = subtotal * coupon.discount_percentage / 100.0
    else
      self.applied_discount = 0
    end
    self.final_total = subtotal - applied_discount
  end
end
