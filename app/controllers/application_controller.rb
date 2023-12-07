class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :authenticate_admin_user!
  helper_method :cart

  private
  def initialize_session
    session[:shopping_cart] ||= {} #empty array of product IDsS
  end

  def cart
    # lookup a product based upon a series of ids
    Game.find(session[:shopping_cart].keys)
  end
end