class VotesController < ApplicationController
  before_filter :assign_link
  
  def new
  end

  def create  
    @vote = Vote.new
    @vote.user = current_user
    @vote.link = @link
    @vote.save

    respond_to do |format|
      if @vote.save
        format.html { redirect_to links_path, :notice => 'You have voted.' }
      end
    end
  end
  
  private
  
  def assign_link
    @link = Link.find(params[:link_id])
  end
end
