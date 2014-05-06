class Student::RegistrationsController < Devise::RegistrationsController
  #before_filter :authenticate
  #layout 'student_layout'
  layout 'student_layout', :only => [:edit, :show]
  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def show
    super
  end

  def update
    super
  end
  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "saurabh"
    end
  end
end
