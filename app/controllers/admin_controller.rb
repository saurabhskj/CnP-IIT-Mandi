require 'will_paginate/array'
require 'rubygems'
require 'zip'

class AdminController < ApplicationController
  before_filter :admin_privilege
  layout 'admin_layout'

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    respond_to do |format|

      if @admin.save
        format.html{ redirect_to root_path }
      else
        format.html { render 'new' }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def company
    @applied_companies = Company.all.map {|comp| comp.name}
    @applied_companies = @applied_companies.uniq
    @job_type = JobType.all.map {|type| type.name}
    @branch_name = Branch.all.map {|b| b.name}
    @applications = StudCompReg.all

    puts "params are ----------- #{params} ----- \n\n"

    if params[:filter]
      puts "\n\n yes \n\n"
      @c_name = params[:company_name]
      @j_name = params[:job_type_name]
      @b_name = params[:branch_name]

      job_type_id  =JobType.where("name like '#{@j_name}'")[0].id
      @companies = Company.where("name like '%#{@c_name}%' and job_type_id = #{job_type_id}")#.id

      if @b_name.empty?
       # branch_id = Branch.where("name like '#{@b_name}'")[0].id
        @student_ids = StudDegreeInfo.all.map {|stud| stud.student_id}
      else
        branch_id = Branch.where("name like '#{@b_name}'")[0].id
        @student_ids = Branch.find(branch_id).stud_degree_infos.map {|stud| stud.student_id}
      end

      @applications = []
      unless @companies.empty? or @student_ids.empty?
       # @applications = []
        @companies.each do |company|
          @applications = @applications + StudCompReg.where("company_id = #{company.id}")
        end
        #company_id = company.id
        #@applications = StudCompReg.where("company_id = #{company_id}")
        @applications = @applications.uniq
        @applications.each_with_index do |app, index|
          unless @student_ids.include?(app.student_id)
            @applications.delete_at(index)
          end
        end
      else
        @applications = []
      end

    end

    if params[:commit] == "Download"
      @application_ids = params[:application_ids]
      unless @application_ids.nil? or @application_ids.empty?
        time = Time.now.localtime.to_s
       # %x(mkdir admin/"#{time}")
        archive_name = "resume_#{time}.zip"

        unless params[:archive_name].empty?
          archive_name = params[:archive_name]+"_#{time}.zip"
        end
        #zipfile_name = "admin/#{time}/#{archive_name}"
        zipfile_name = "admin/#{archive_name}"
        folder_names = []
        file_names = []
        student_ids = []
        company_names = []
        puts "\n\n@application_ids: #{@application_ids}\n\n"

        @application_ids.each do |app_id|
          app = StudCompReg.find(app_id.to_i)
          company_names.push(Company.find(app.company_id).name)
          resume = Resume.find(app.resume_id)
          #resume_name, student_id =  resume.name, resume.student_id

          file_names.push(resume.name)
          student_ids.push(app.student_id)
          folder_names.push(app.student_id)
        end

        puts "filenames are : #{file_names} \n student_ids: #{student_ids}\n\n"

        Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        #Zip::ZipFile.open(zipfile_name, "w") do |zipfile|
          file_names.each_with_index do |filename, index|
            zipfile.add(student_ids[index].to_s + "_#{filename.delete(".pdf")}_#{company_names[index]}.pdf", "lib/resumes/#{student_ids[index]}/"+ filename)
          end
          zipfile.get_output_stream("ReadMe") { |os| os.write "File Description to be given here." }
        end


        download(time, archive_name)
      else
        redirect_to admin_company_path
      end

      #redirect_to admin_company_path
    end

  end

  def download(folder_name, archive_name)
    path = "#{Rails.root.to_s}/admin/#{archive_name}"
    send_file path, type: 'application/zip', :x_sendfile => true
  end

  def mail
    @students = Student.all
    puts "Testing"
    @students = Student.search(params[:student_name])
    @students = @students.paginate(page: params[:page], per_page: 4)

    if params[:send_mail]

      flash[:mail_success] = "Mail successfully sent."
      redirect_to admin_mail_path
      return
    end
    respond_to do |format|
      format.html {render}
      format.json {render :json}
    end
  end

  def index

  end
end
