class GameOrder < ApplicationRecord
  belongs_to :game
  belongs_to :order
  belongs_to :user

  validates :game_order_id, presence: true
  validates :order_id, presence: true
  validates :game_id, presence: true
  validates :quantity, presence: true
end