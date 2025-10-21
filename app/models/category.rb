class Category < ApplicationRecord
  belongs_to :parent, class_name: Category.name, optional: true
  has_many :subcategories, class_name: Category.name, foreign_key: :parent_id, dependent: :destroy

  has_many :products

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
