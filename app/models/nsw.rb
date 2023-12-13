class NSW < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true
  has_many_attached :images
end