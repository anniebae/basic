namespace :db do
  desc "empty users table"
  task :empty_users_table => :environment do
    User.destroy_all
  end  
end