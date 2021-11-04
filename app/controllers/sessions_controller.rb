class SessionsController < ApplicationController

  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "User successfully logged in"
      redirect_to user
    else
      flash.now[:alert] = "Something went wrong"
      render 'new'
    end
  end

  def omniauth
    @user = User.from_omniauth(auth)
    @user.save
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "logged out"
    redirect_to root_path
  end

  

  private
  def auth
    request.env['omniauth.auth']
  end
  
  
end