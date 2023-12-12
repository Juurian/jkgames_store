class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :cart

  private

  def initialize_session
    session[:shopping_cart] ||= {}
  end

  def cart
    Game.find(session[:shopping_cart].keys)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :phone_number, :province])
  end

end
