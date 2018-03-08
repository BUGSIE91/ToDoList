class UsersController < ApplicationController

  def new
    @user = User.new
  end

  # Invoked when user cliks on sign up, uses the user_params method to build object.
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      @user.errors.messages.each do |name, msg|
        flash[name.to_sym] = "#{name}: #{msg.join(', ')}" 
      end
      redirect_to '/users/new'
    end 
  end

  private

  # Used for building a user object from user's form input
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
