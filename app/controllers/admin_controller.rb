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

    @branch_name = Branch.all.map {}

  end

  def index

  end
end
