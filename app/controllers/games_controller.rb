class GamesController < ApplicationController
  def index
    @games = Game.page(params[:page]).per(24)
  end

  def show
    @game = Game.find(params[:id])
  end

  # renders off of search results
  def search
    @games = Game.where("title LIKE ?", "%#{params[:search]}%").page(params[:page]).per(10)
    render 'index'
  end
end
