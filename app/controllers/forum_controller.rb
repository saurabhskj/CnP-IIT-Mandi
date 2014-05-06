require 'will_paginate/array'

class ForumController < ApplicationController
  before_filter :admin_privilege, :only => [:new, :create]
  layout 'student_layout'

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
