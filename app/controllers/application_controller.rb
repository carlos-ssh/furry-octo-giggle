class ApplicationController < ActionController::Base
  # skip_before_filter :authenticate_user!, if: :json_request?
# skip user authentication for POST methods with JSON format.
# with this example, you can use POST methods with JSON format without authentication.
#   skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :authenticate_user!, except: [:new, :create]
  # # before_action :authenticate_user!, except: [:new, :create, :index, :show]
  # Resque form for invalid authentificitytoken
  rescue_from ActionController::InvalidAuthenticityToken, :with => :bad_token
  def bad_token
    flash[:warning] = "Session expired"
    redirect_to root_path
  end

  def after_sign_in_path_for(resource)
    # if current_user.admin?
    #   pages_dashboard_path
    # else
    #   root_path
    # end
    pages_dashboard_path
  end

  def json_request?
    request.format.json?
  end
end
