class GamesGadgetsController < ApplicationController
  def index
    @games_gadgets = GamesGadget.page(params[:page]).per(10)
  end
end
