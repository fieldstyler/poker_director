class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_active_section
  helper_method :active_section

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  def active_section
    @active_section
  end 

  private 

  def set_active_section
    @active_section ||= nil
  end 
end
