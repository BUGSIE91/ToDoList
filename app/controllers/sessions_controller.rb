class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.where(email: params[:session][:email]).first
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.first_name}"
    else
      flash[:notice] = "Invalid credentials. Please try again"
    end
    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out of the system"
    redirect_to '/'
  end

end
