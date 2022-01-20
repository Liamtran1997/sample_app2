class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in(user) # Take User_id to Session Value
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or(user)
      # remember(user) # Remembers a user in a persistent session.
      # redirect_to user # Rails automatically converts this to the route for the user’s profile page
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
