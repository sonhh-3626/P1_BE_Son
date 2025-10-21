class BillingDetail < ApplicationRecord
  belongs_to :order

  validates :first_name, :last_name, :country_region,
            :street_address, :town_city, :state,
            :zip_code, :phone, :email, presence: true
end
