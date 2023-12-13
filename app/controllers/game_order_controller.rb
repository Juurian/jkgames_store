class GameOrdersController < ApplicationController
  belongs_to :game
  belongs_to :order
end