class CommentsController < ApplicationController
  before_filter :assign_link
  before_filter :assign_subject

  def new
    Comment.new
  end

  def create
    @comment = current_user.comments.build(params[:comment])
    @comment.subject = @subject
    @link = @comment.link

    respond_to do |format|
      if @comment.save && @subject.class == Link
        format.html { redirect_to @link, :notice => 'Thanks for your comment' }
      elsif @comment.save && @subject.class == Comment
        format.html { redirect_to @subject, :notice => 'Thanks for your comment' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def show
    @head_comment = Comment.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(:subject_id => params[:id]).all
    @comments.delete_if {|comment| comment.subject_type != "Comment"}
    @link = @head_comment.link
  end

  private

  # def set_user
  #   @current_user = User.find(session[:user_id])
  # end

  def assign_link
    @link = Link.find(params[:link_id]) if params[:link_id]
  end

  def assign_subject
    if params[:id]
      @subject = Comment.find(params[:id])
    elsif params[:comment_id]
      @subject = Comment.find(params[:comment_id])
    elsif params[:link_id]
      @subject = Link.find(params[:link_id])
    end
  end

end
