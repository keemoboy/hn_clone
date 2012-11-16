class LinksController < ApplicationController

  before_filter :check_user, :check_time, :only => :edit
  before_filter :check_user, :only => :destroy
  # before_filter :set_user

  def index

    @links = Link.all

    @links.sort_by!{|link| -link.votes.count} if session[:view_preference] == "vote"


    respond_to do |format|
      format.html
    end
  end

  def show
    @link = Link.find(params[:id])
    @comment = Comment.new

    @comments = Comment.where(:subject_id => params[:id]).all
    @comments.delete_if {|comment| comment.subject_type != "Link"}

    respond_to do |format|
      format.html
    end
  end

  def new
    @link = Link.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def create
    @link = current_user.links.build(params[:link])


    respond_to do |format|
      if @link.save
        format.html { redirect_to links_path, :notice => 'Link was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to links_path, :notice => 'Link was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to '/links'
  end

  private

  def check_user
    @link = Link.find(params[:id])
    redirect_to links_path, :notice => 'Only the creator of this link can edit it' if @link.user_id != current_user.id
  end

  def check_time
    @link = Link.find(params[:id])
    redirect_to links_path, :notice => 'You can only edit your link within 15 minutes of posting it' if Time.now - @link.created_at > 900
  end

  # def set_user
  #   @current_user = User.find(session[:user_id])
  # end

end
