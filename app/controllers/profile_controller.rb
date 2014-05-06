class ProfileController < ApplicationController
  before_filter :user_privilege
  layout 'student_layout'
  def index

  end

  def my_profile

    if student_signed_in?
      @contact_info =  current_student.contact_info
      puts "Current Contact ID: --------- #{@contact_info.id} \n\n\n"
      @details = current_student
     # layout 'student_layout'
    elsif admin_signed_in?
      @contact_info =  current_admin.contact_info
      puts "Current Contact ID: --------- #{@contact_info.id} \n\n\n"
      @details = current_admin

    end

    puts "params ------------------#{params}\n\n\n"
    unless params[:phone_number1].nil? || params[:personal_email].nil?
      ContactInfo.update(@contact_info.id, phone_number1: params[:phone_number1], personal_email: params[:personal_email],
        phone_number2: params[:phone_number2] )
      flash[:message] = "Information Successfully updated!"
      redirect_to root_path
      return
    end
    respond_to do |format|
      format.html {render }
      format.json {render :json}
    end
  end

end
