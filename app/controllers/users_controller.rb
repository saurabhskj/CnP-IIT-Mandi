class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html {render root_path}
      else
        format.html {render 'new'}
        format.json {render :json}
      end
    end
  end
end
