class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin_privilege
    unless current_admin
      flash[:error] = "Access Denied"
      redirect_to root_path and return false
    end
  end

end
