class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create

  def survey? 
    # determine whether or not user has submitted initital survey.  return true if they have.  return false if otherwise.
    survey_completed


    # if survey_completed == true
    #   user.survey_completed = "t"
    # else
    #   survey_completed
    # end

  end

  def self.sort_by_total_score
    puts 'sorting....'
    ranked_by_total = self.all.sort_by do |user|
      user.total_score
    end
    ranked_by_total.reverse
  end

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

    # words = ["starbucks", "psl", "pumpkin spice latter", "uggs", "I can't even", "I literally can't", "I just can't", "juicy", "tiffany's", "plur", "edm", "event", "food", "breakfast", "brunch", "lunch", "dinner", "girlfriend", "gf", "boyfriend", "bf", "north face", "fleece", "ootd", "tbt", "throwback", "fashion", "michael kors", "armcandy", "reality", "bravo", "yoga", "pants", "lululemon", "shopping", "pinterest", "diy", "skinny", "sorority", "frat", "selfie", "selfies", "neon", "nike", "rosche", "wait", "duckface", "kiss", "xoxo", "love", "peace", "qotd", "mani", "pedi", "nails", "bad hair day", "vegas", "hot dogs or legs", "diet", "lol", "omg", "lmao", "ryan gosling", "channing tatum", "joseph gordon-levitt", "joseph gordon levitt", "jgl", "gym", "workout", "iphone", "coffee", "latte", "cappuccino", "frap", "espresso", "run", "like", "basic", "caramel", "macchiato", "fitness", "half", "water", "seltzer", "half", "baby", "shoes", "sale", "favorite", "fave", "bestfriend", "bestie", "besties", "bff", "bffs", "obvi", "obviously", "yolo", "swag", "bitch", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday", "turnt", "adorable", "ugh", "cute", "so cute", "sweater weather", "tgif", "sunday funday", "twinsies", "funsies", "ew", "totally", "totes", "yay", "mirror", "outfit", "last night", "mimosas", "bloody mary", "bottomless brunch"]

    score = {}
    words.each { |word| score[word] = posts.join(' ').downcase.scan(word).count }
    score
  end

  def basic_score
    # self.score = self.insta_score.
    score = self.insta_score
    score.each {|key, count| score[key] += count }
    score.inject(3) { |sum, value| sum += value[1] }
    # Build from other scores
  end

  def total_score
    self.basic_score + self.survey_score
  end

end
