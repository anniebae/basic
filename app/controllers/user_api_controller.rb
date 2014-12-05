class UserApiController < ApplicationController

  def index
    users = User.all
    render json: users.to_json
  end

  def show
    user = User.find(params[:id])
    render json: user.to_json
  end

  def instagram_posts
    user = User.find(params[:id])
    render json: user.instagram_posts.to_json
  end

end



# {
# id: 14307,
# turns: "0147593",
# state: "XO-XXX-O-O",
# complete: true,
# winner: "X"
# },