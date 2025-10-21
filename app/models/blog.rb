class Blog < ApplicationRecord
  belongs_to :author, class_name: User.className

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 20 }
end
