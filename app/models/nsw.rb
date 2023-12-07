class NSW < ApplicationRecord
  validates :title, presence: true
  has_many_attached :images
end