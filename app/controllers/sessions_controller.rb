class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to links_path, :notice => "Logged in!"
      session[:view_preference] = "date"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def date_view
    session[:view_preference] = "date"
    redirect_to links_path
  end

  def vote_view
    session[:view_preference] = "vote"
    redirect_to links_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_user_path, :notice => "Logged out!"
  end
end
