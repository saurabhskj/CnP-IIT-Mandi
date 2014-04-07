class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @forum = Forum.find(params[:forum_id])
    @comment = @forum.comments.create(params[:comment])

    redirect_to forum_path(@forum)
  end
end
