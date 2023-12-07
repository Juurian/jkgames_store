class Xb1Controller < ApplicationController
  def index
    @games = Game.where(platform: 'XBOX ONE').page(params[:page]).per(24)
  end

  def show
    @game = Game.find(params[:id])
  end

  # renders off of search results
  def search
    @games = Game.where(platform: 'XBOX ONE').where("title LIKE ?", "%#{params[:search]}%").page(params[:page]).per(10)
    render 'index'
  end

  # shows the image from active storage
  def show_image
    image_name = params[:image_name]
    send_file Rails.root.join('public', 'storage', 'game_master_image', game_id, "#{game_id}.jpg"), disposition: 'inline'
  end
end
