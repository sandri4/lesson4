class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: user_params[:name])
    @user ||= User.create(user_params)
    if @user.valid? && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to tasks_path
    end
  end

  def destroy
    User.find(session[:user_id])
    session[:user_id] = nil
    redirect_to :root
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end
end
