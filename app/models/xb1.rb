class XB1 < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true
  has_many_attached :images
end