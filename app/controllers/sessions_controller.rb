class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      flash.now[:danger] = "You have an incorrect email address or password"
      render :new
    end
  end
  def destroy
    # deletes user session
    session[:user_id] = nil
    redirect_to root_path, notice: 'You are logged out'
  end
  private
   def user_params
    params.require(:session).permit(:email, :password)
   end
 end
