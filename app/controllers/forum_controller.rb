require 'will_paginate/array'

class ForumController < ApplicationController
  before_filter :admin_privilege, :only => [:new, :create]
  layout :check_user

  private
  def check_user
    if student_signed_in?
      'student_layout'
    else
      'admin_layout'
    end
  end

  public
  def new
    forum = Forum.new
  end

  def create
    forum = Forum.new(params[:forum])

    respond_to do |format|
      format.html {render}
      format.json {render :json}
    end
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def index
    @forums = Forum.all
    @forums = @forums.paginate(page: params[:page], per_page: 5 )
    respond_to do |format|
      format.html {render }
      format.json {render :json}
    end
  end

  def show
    @forum = Forum.find(params[:id])
    @comments = @forum.comments

    respond_to do |format|
      format.html {render}
      format.json {render :json}
    end

  end
end
