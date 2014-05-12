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

    elsif admin_signed_in?
      @contact_info =  current_admin.contact_info
      puts "Current Contact ID: --------- #{@contact_info.id} \n\n\n"
      @details = current_admin
    end

    puts "params ------------------#{params}\n\n\n"

    if params[:personal_info]
      category_id = Category.where("name like '#{params[:category_name]}%'").first.id
      Student.update(current_student.id, first_name: params[:first_name], middle_name: params[:middle_name],
                     last_name: params[:last_name], dob: params[:dob], gender: params[:gender],
                     category_id: category_id, hostel_name: params[:hostel_name], hostel_address: params[:hostel_address],
                     city: params[:city], state: params[:state])

      flash[:message] = "Information successfully updated."
      redirect_to my_profile_path
      return
    end

    if params[:submit_contact_info]
      unless params[:phone_number1].nil? || params[:personal_email].nil?
        ContactInfo.update(@contact_info.id, phone_number1: params[:phone_number1], personal_email: params[:personal_email],
          phone_number2: params[:phone_number2] )
        flash[:message] = "Information Successfully updated."
        redirect_to my_profile_path
        return
      end
    end

    @branch_names = Branch.all.map {|br| br.name}
    @degree_names = Degree.all.map {|dg| dg.name}

    @degree_info = current_student.stud_degree_info
    @year = @degree_info.year_of_grad
    @enrol_number = @degree_info.enrolment_number

    if params[:submit_degree_info]
     # puts "\n\n YES \n\n"

      branch_id = Branch.where("name like '#{params[:branch_name]}%'").first.id
      degree_id = Degree.where("name like '#{params[:degree_name]}%'").first.id
      StudDegreeInfo.update(current_student.stud_degree_info.id, degree_id: degree_id, branch_id: branch_id,
                            year_of_grad: params[:year_of_grad].to_i, enrolment_number: params[:enrol_number])
      flash[:message] = "Information successfully updated."
      redirect_to my_profile_path
      return
    end

    respond_to do |format|
      format.html {render }
      format.json {render :json}
    end
  end

end
