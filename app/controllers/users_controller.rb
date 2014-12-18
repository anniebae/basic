class UsersController < ApplicationController

  before_filter :authorize, except: [:new, :create, :login]

  def index
    @users = User.sort_by_total_score
    # @users = User.all
    respond_to do | format |
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    session[:user_id] = user.id
    if user.persisted?
      redirect_to user_path(user)
    else 
      @user = User.new
      render :new
    end
  end

  def edit
    @user = User.new
  end

  def update
    survey = params["survey"]

    # calculates survey_score
    response_yes = survey.select { |question, response | response == "YES" }.length
    current_user.survey_score = response_yes * 3
    current_user.survey_completed = true
    current_user.save!
    redirect_to "/#users"
    # user.survey_score = (survey.select{ |question, response| response = "yes" }.length * 3)

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