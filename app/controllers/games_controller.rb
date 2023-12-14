class GamesController < ApplicationController
  def index
    @games = Game.page(params[:page]).per(24)
  end

  def show
    @game = Game.find(params[:id])
  end

  def search
    @games = Game.where("title LIKE ?", "%#{params[:search]}%")

    case params[:filter]
    when 'newly_added'
      @games = @games.where("created_at >= ?", 3.days.ago).order(created_at: :desc)
    when 'recently_modified'
      @games = @games.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago).order(updated_at: :desc)
    when 'by_genre'
      if params[:genre].present? && params[:genre] != 'All Genres'
        @games = @games.where("genre LIKE ?", "%#{params[:genre]}%")
      end
    end

    @games = @games.page(params[:page]).per(10)
    render 'index'
  end


  # shows the image from active storage
  def show_image
    image_name = params[:image_name]
    send_file Rails.root.join('public', 'storage', 'game_master_image', game_id, "#{game_id}.jpg"), disposition: 'inline'
  end
end
