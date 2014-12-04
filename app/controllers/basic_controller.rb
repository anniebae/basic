query = params['query'].gsub(' ', +)
url = "https://api.untappd.com/v4/search/beer?=#{query}client_id=CLIENTID&client_secret=CLIENTSECRET"

response = HTTParty.get( url )

beer_name = response['beer']['beer_name']

#id
3f3ba198c9e5470588e9a0046065b361


#sec
c8493b7caf4745aab9e54a972b382c0e

#code
5d079a63b2c240728c3e69beb082d203

#token
19035535.3f3ba19.cb0a2e4409fd437cb3e80e677a1c37f9

----------------------------------------------------------------

class BasicController < ApplicationController
  def index

    # gets all users with 'anniebae' in username
    url = "https://api.instagram.com/v1/users/search?q=anniebae&access_token=19035535.3f3ba19.cb0a2e4409fd437cb3e80e677a1c37f9"  
    api_response = HTTParty.get(url)

    # gets user_id for first 'anniebae' in results from above
     user_id = api_response["data"][0]["id"]

    # gets most recent media from 'anniebae'
    url = "https://api.instagram.com/v1/users/19035535/media/recent/?access_token=19035535.3f3ba19.cb0a2e4409fd437cb3e80e677a1c37f9"
    api_response = HTTParty.get(url)

    # gets ALL of latest (last 20) texts from posts
    latest_posts = api_response['data'].map { |post| post['caption']['text'] }  

  end


  def show
  end


end