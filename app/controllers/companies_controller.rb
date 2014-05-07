require 'will_paginate/array'
class CompaniesController < ApplicationController
  before_filter :user_privilege
  layout 'student_layout'
  

  def index

    puts "company name ----------------------- #{params[:search_company]}"
    #job_type = "Intern"
    @companies  = Company.search(params[:search_company] , 1)

    @companies = @companies.paginate(page: params[:page], per_page: 4)
    @student_id = current_student.id
    @resume_name = []

    Dir.foreach("lib/resumes/#{@student_id}") do |file_name|
      next if file_name == '.' or file_name == '..'
      @resume_name.push([file_name])
    #  puts "resume ------- #{file_name} \n\n"
    end

    puts "params selected on company reg. page: -- #{params}"
    puts "Company id selected: ------ #{params[:company_id]}"
    unless params[:company_id].nil?
      res_id = 9
      StudCompReg.create_registration(@student_id, params[:company_id].to_i, res_id)
      redirect_to companies_path
      return
    end

    respond_to do |format|
      format.html {render}
      format.json {render :json}
    end
  end

end
