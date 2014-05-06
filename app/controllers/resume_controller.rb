class ResumeController < ApplicationController
  before_filter :user_privilege
  layout 'student_layout'

  def new

  end

  def create

  end

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

  #  puts "#{params}"

    if params[:upload].nil? == false
      Resume.upload(student_id, params[:upload][:file])
      redirect_to resume_path
    elsif params[:method] == "get"
      flash[:upload_error] = "Please choose a file to upload."
      redirect_to resume_path
    end

  end

  def upload_file

  end
end
