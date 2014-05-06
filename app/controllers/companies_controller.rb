require 'will_paginate/array'
class CompaniesController < ApplicationController
  before_filter :user_privilege
  layout 'student_layout'
  def new

  end

  def create

  end

  def index

    puts "company name ----------------------- #{params[:search_company]}"
    @companies  = Company.search(params[:search_company])

    puts "size ---------- #{@companies.size()} \n\n"
    @companies = @companies.paginate(page: params[:page], per_page: 4)

    respond_to do |format|
      format.html {render}
      format.json {render :json}
    end
  end
end
