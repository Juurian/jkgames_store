class Game < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true

  has_many :game_orders
  has_many :orders, through: :game_orders
  has_many_attached :images
end