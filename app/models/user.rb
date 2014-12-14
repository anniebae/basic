class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create


  def completed_survey?
    return survey_completed
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
    api_response = HTTParty.get("https://api.instagram.com/v1/users/search?q=#{username}&access_token=#{ENV['INSTAGRAM_TOKEN']}")
    api_response["data"][0] rescue {}
  end

  def instagram_profile_picture
    self.instagram_account_info["profile_picture"]
  end

  def instagram_account_id
    self.instagram_account_info["id"]
  end

  def instagram_posts
    instagram_id = self.instagram_account_id
    api_response = HTTParty.get("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?access_token=#{ENV['INSTAGRAM_TOKEN']}")
    api_response['data'].map do |post| 
      if post['caption']
        post['caption']['text']
      else
        ''
      end
    end
  end

  def insta_score
    posts = self.instagram_posts
    words = ["starbucks", "i can't even", "thanks", 'some', 'wall']

    # words = ["starbucks", "psl", "pumpkin spice latter", "uggs", "I can't even", "I literally can't", "I just can't", "juicy", "tiffany's", "plur", "edm", "event", "food", "breakfast", "brunch", "lunch", "dinner", "girlfriend", "girlfriends", "gf", "boyfriend", "bf", "north face", "fleece", "ootd", "tbt", "throwback", "fashion", "michael kors", "armcandy", "reality", "bravo", "yoga", "pants", "lululemon", "lululemons", "shopping", "pinterest", "diy", "skinny", "fat", "sorority", "frat", "selfie", "selfies", "neon", "nike", "rosche", "wait", "duckface", "kiss", "xoxo", "love", "peace", "qotd", "mani", "pedi", "nails", "bad hair day", "vegas", "hot dogs or legs", "diet", "lol", "omg", "lmao", "ryan gosling", "channing tatum", "joseph gordon-levitt", "joseph gordon levitt", "jgl", "gym", "workout", "iphone", "coffee", "latte", "cappuccino", "frap", "espresso", "run", "like", "basic", "caramel", "macchiato", "fitness", "half", "water", "seltzer", "half", "baby", "shoes", "sale", "favorite", "fave", "bestfriend", "bestie", "besties", "bff", "bffs", "obvi", "obviously", "yolo", "swag", "bitch", "bitches", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday", "turnt", "adorable", "ugh", "cute", "so cute", "sweater weather", "tgif", "sunday funday", "twinsies", "funsies", "ew", "totally", "totes", "yay", "mirror", "outfit", "last night", "mimosas", "bloody mary", "bottomless brunch", "namaste", "obsessed", "bagel", "bagels", "boozy", "i die", "morning", "goodnight", "exercise", "blessed", "situation", "!", "ily", "ilysm", "imy", "ride or die", "i die", "basic", "throwback", "caffeine", "sample", "quote", "fetch", "def", "fabulous", "fab"]

    
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

  def as_json(options) 
    super(:methods => [:instagram_account_info, :instagram_profile_picture, :total_score])
  end

end
