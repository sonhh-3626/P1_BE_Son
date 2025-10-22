class BillingDetail < ApplicationRecord
  belongs_to :order

  validates :first_name, :last_name, :country_region,
            :street_address, :town_city, :state,
            :zip_code, :phone, :email, presence: true
  validates :apartment_suite, :order_notes, presence: false, allow_nil: true
  validates :create_account, :ship_to_a_different_address, inclusion: { in: [true, false] }
end
