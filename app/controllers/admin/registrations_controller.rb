class Admin::RegistrationsController < Devise::RegistrationsController
  before_filter :admin_privilege
  #before_filter :authenticate
  #layout 'admin_layout'

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "saurabh"
    end
  end
end
