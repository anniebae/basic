class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create


  def instagram_account_info
    # gets all users with 'anniebae' in username
    username = self.instagram_account
    api_response = HTTParty.get("https://api.instagram.com/v1/users/search?q=#{username}&access_token=19035535.3f3ba19.cb0a2e4409fd437cb3e80e677a1c37f9")
    api_response["data"][0]
  end

  def instagram_profile_picture
    self.instagram_account_info["profile_picture"]
  end

  def instagram_account_id
    self.instagram_account_info["id"]
  end

  def instagram_posts
    instagram_id = self.instagram_account_id
    api_response = HTTParty.get("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?access_token=19035535.3f3ba19.cb0a2e4409fd437cb3e80e677a1c37f9")
    api_response['data'].map { |post| post['caption']['text'] } 
  end

  def insta_score
    posts = self.instagram_posts
    words = ["starbucks", "i can't even", "thanks", 'some', 'wall']
    score = {}
    words.each { |word| score[word] = posts.join(' ').downcase.scan(word).count }
    score
  end

  def basic_score
    self.score = self.insta_score.


    # Build from other scores
  end

end
