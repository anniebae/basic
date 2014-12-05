class AddSurveyCompletedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :survey_completed, :boolean, default: false
  end
end
