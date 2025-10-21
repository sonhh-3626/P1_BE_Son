class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :blogs, foreign_key: :author_id, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  validates :role, inclusion: { in: %w(customer vendor admin) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
