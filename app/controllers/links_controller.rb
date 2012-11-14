class LinksController < ApplicationController

  def index
    @links = Link.all

    respond_to do |format|
      format.html 
    end
  end

  def show
    @link = Link.find(params[:id])

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
    redirect_to links_path, :notice => 'Only the creator of this link can edit it' if @link.user_id != current_user.id
    redirect_to links_path, :notice => 'You can only edit your link within 15 minutes of posting it' if Time.now - @link.created_at > 900
  
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
    
    redirect_to links_path, :notice => 'Only the creator of this link can edit it' if @link.user_id != current_user.id
    redirect_to links_path, :notice => 'You can only edit your link within 15 minutes of posting it' if Time.now - @link.created_at > 900
    
    @link.destroy

  end
  
end
