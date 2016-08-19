class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])
      # Log in
      session[:user_id] = @user.id
      redirect_to '/'
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  # Used to check if a user is logged in
  def check    
  end
end
