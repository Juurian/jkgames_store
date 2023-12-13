class Order < ApplicationRecord
  has_many :game_orders
  has_many :games, through: :game_orders

  belongs_to :user
end
