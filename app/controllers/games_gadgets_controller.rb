class GamesGadgetsController < ApplicationController
  def index
    @games_gadgets = GamesGadget.all
  end
end
