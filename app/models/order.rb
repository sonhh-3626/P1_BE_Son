class Order < ApplicationRecord
  belongs_to :user
  belongs_to :coupon, optional: true

  has_many :order_items, dependent: :destroy
  has_one :billing_detail, dependent: :destroy

  accepts_nested_attributes_for :billing_detail
  accepts_nested_attributes_for :order_items

  enum :status, { processing: 0, shipped: 1, completed: 2, refunded: 3, cancelled: 4 }

  validates :subtotal, :final_total, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  scope :processing, -> { where(status: :processing) }
  scope :shipped, -> { where(status: :shipped) }
  scope :completed, -> { where(status: :completed) }
  scope :refunded, -> { where(status: :refunded) }
  scope :cancelled, -> { where(status: :cancelled) }
end
