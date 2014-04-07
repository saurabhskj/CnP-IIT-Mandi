class Admin::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, :only => :create
  prepend_before_filter :only => [ :create, :destroy ] #{ request.env["devise.skip_timeout"] = true }

 # before_filter :authenticate
  #layout 'admin_layout'

  def new
    super
  end

  def create
    super
  end

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "saurabh"
    end
  end
end