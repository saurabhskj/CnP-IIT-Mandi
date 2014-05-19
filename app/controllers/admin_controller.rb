require 'will_paginate/array'
require 'rubygems'
require 'zip'
require 'csv'

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

      @applications = []
      if @b_name.empty?
       # branch_id = Branch.where("name like '#{@b_name}'")[0].id
        @student_ids = StudDegreeInfo.all.map {|stud| stud.student_id}
      else
        branch_id = Branch.where("name like '#{@b_name}'")[0].id
        puts "branch id: ------------- #{branch_id}\n\n"
        @student_ids = Branch.find(branch_id).stud_degree_infos.map {|stud| stud.student_id}
        puts "student_ids ------------ #{@student_ids}"
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

      @applications = @applications.paginate(page: params[:page], per_page: 4)
    end

    if params[:save_detail]
      unless params[:application_ids].nil?
        @application_ids  = params[:application_ids].map {|app| app.to_i}

        @shortlist_ids = []
        if params[:shortlist]
          @shortlist_ids = params[:shortlist]
          @shortlist_ids.delete("")
        end

        unless @shortlist_ids.empty?
         # @shortlist_ids.delete("")
          puts "shortlisted ids are: ------------ #{@shortlist_ids}\n\n"
          @shortlist_ids.each do |shl|
            value, id = shl.split(',')
            if @application_ids.include? id.to_i
              stud_app = StudCompReg.find(id.to_i)
              stud_app.shortlisted = value
              stud_app.save!
            end
          end
        end

        @select_ids = []
        if params[:select]
          @select_ids = params[:select]
          @select_ids.delete("")
        end
        #check_select = params[:select].uniq.first

        unless @select_ids.empty?
      #    @select_ids.delete("")
          @select_ids.each do |sel|

            value,id = sel.split(',')
            if @application_ids.include? id.to_i
              stud_app = StudCompReg.find(id.to_i)
              stud_app.selected = value
              puts "student id selected ---------- #{stud_app.student.first_name}, -- #{value}\n"
              stud_app.save!
            end
          end
        end

      else
        flash[:application_error] = "Application IDs not selected. Please select to save the data corresponding to it."
      end
      redirect_to admin_company_path
      return
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
    @s_name = params[:student_name]
    @students = @students.paginate(page: params[:page], per_page: 4)

    if params[:send_mail]

      @student_ids = params[:student_ids]

      unless @student_ids.nil? or @student_ids.empty?
        @student_ids.each do |student_id|
          subject = "Message from CnP Cell, IIT Mandi"
          UserMailer.notify_email(student_id.to_i, subject, params[:message]).deliver
        end
      end
      flash[:mail_success] = "Mail successfully sent."
      redirect_to admin_mail_path
      return
    end
    respond_to do |format|
      format.html {render}
      format.json {render :json}
    end
  end

  def reports
 #   @job_type = JobType.all.map {|type| type.name}
    @branch_name = Branch.all.map {|b| b.name}

    @companies = Company.all.map {|company| company.name}
    @year_of_grads = YearOfGraduation.all.map {|y| y.year}
    @comp_name = params[:company_name]
    @year_grad_number = params[:year_number]
#    @j_name = params[:job_type_name]
    @b_name = params[:branch_name]
    @students = []
    if params[:company_submit] and params[:company_name]

      company_id = Company.where("name like '%#{params[:company_name]}%'").first.id
      puts "company_id = #{company_id}\n\n"
      @student_ids = StudCompReg.where("company_id = #{company_id}").map {|app| app.student_id }

      s = ""
      @student_ids.each do |student_id|
        s += "#{student_id},"
       # @students.push(Student.find(student_id))
      end

      @students = Student.where("id in ('#{s[0..s.length-2]}')")
      puts "students --------- #{@students} \n\n"
      @students.order :first_name
      send_data @students.to_csv
      return
    end

    if params[:year_number] and params[:year_submit]
      year_id = YearOfGraduation.where("year = #{params[:year_number].to_i}").first.id

      puts "year_id --- #{year_id}"
      @students = Student.where("year_of_graduation_id = #{year_id}")
     # @students = Student.find(:all, :select => 'id, first_name, last_name', :conditions => "year_of_graduation_id = #{year_id}")
      #@students = YearOfGraduation.find(year_id).students
      @students.order :first_name, :last_name
      send_data @students.to_csv
      return
    end

   # if params[:upload].nil? == false
   #   Resume.upload(student_id, params[:upload][:file])
   #   redirect_to resume_path
   # elsif params[:upload_resume].nil? == false and params[:upload_resume].empty?
   #   flash[:upload_error] = "Please choose a file to upload."
   #   redirect_to resume_path
   # end

    if params[:upload].nil? == false and params[:year_number]
      year_id = YearOfGraduation.where("year = #{params[:year_number].to_i}").first.id
      directory = "lib/admin"
      file_name = params[:upload][:datafile]
      path = File.join(directory, file_name)
      #write the file
      File.open(path, "wb") {|file| file.write(file_name)}

      Admin.upload_file(params[:upload][:datafile], year_id)
      csv_text = File.read(path)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        puts "\nrow value ----------------- #{row.to_hash}\n"
      end


      redirect_to admin_reports_path
      return
    elsif params[:upload_data].nil? == false and params[:upload_data].empty?
      flash[:upload_error] = "Please choose a file to upload."
      #redirect_to admin_reports_path
    end
    #@students = Student.order(:first_name)

    respond_to do |format|
      format.html
      format.csv { send_data @students.to_csv }
      #format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  def index

  end

end