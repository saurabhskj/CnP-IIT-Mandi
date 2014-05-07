require 'will_paginate/array'

class ResumeController < ApplicationController
  before_filter :user_privilege
  layout 'student_layout'

  def index
    puts "\n\n ---------- #{params[:upload]} ----------- \n\n"
    student_id = current_student.id

    # Checking whether directory for current exist or not
    @dirs = %x(ls lib/resumes/* -d).split("\n")
    @dir_names = {}  # Hash to map all the current directories.

    @dirs.map do |dir|
      val = dir.split("/")[2].to_i
      @dir_names[val] = val
    end

    if @dir_names[student_id] != student_id  # check whether a directory corresponding to current user exist or not
      %x(mkdir lib/resumes/"#{student_id}")
    end

    # puts "#{params}"

    if params[:upload].nil? == false
      Resume.upload(student_id, params[:upload][:file])
      redirect_to resume_path
    elsif params[:upload_resume].nil? == false and params[:upload_resume].empty?
      flash[:upload_error] = "Please choose a file to upload."
      redirect_to resume_path
    end

    @cur_resumes = Resume.search(student_id, params[:search_resume])

    @cur_resumes = @cur_resumes.paginate(page: params[:page], per_page: 4)

    unless params[:resume_id].nil?
      download(params[:resume_id].to_i)
    end

   # respond_to do |format|
    #  format.html {render}
    #  format.json {render :json}
   # end
  end


  def download(resume_id)

    res = Resume.find(resume_id)
    student_id = current_student.id

    path = "#{Rails.root.to_s}/lib/resumes/#{student_id}/#{res.name}"
    send_file path, type: 'application/pdf', :x_sendfile => true
    #redirect_to resume_path
  #  @files = Dir.glob(path+"*")
  end
end
