class StudentsController < ApplicationController
  layout 'student_layout'

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params[:students])
    respond_to do |format|
      if @student.save
        format.html { redirect_to root_path}
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def index

  end
end
