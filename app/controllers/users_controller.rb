class UsersController < ApplicationController

  before_filter :authorize, except: [:new, :create, :login]

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def new
    # cuz we using a form helper
    @user = User.new
  end

  def create
    user = User.create(user_params)
    redirect_to user_path(user)
    
    
  end

  def edit
    @user = User.new
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    redirect_to users_path
  end

  def login

  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :instagram_account)
  end

end