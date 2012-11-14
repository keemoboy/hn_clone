class VotesController < ApplicationController
  before_filter :assign_link

  def new
  end

  def create
    @vote = Vote.new
    @vote.user = @current_user
    @vote.link = @link
    @vote.save
    @links = Link.all
    if @vote.save
      render "links/index"
    else
      render "links/index"
    end
  end

  private

  def assign_link
    @link = Link.find(params[:link_id])
  end

  def set_user
    @current_user = User.find(session[:user_id])
  end
end
