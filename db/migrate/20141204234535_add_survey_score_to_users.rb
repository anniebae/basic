class AddSurveyScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :survey_score, :integer
  end
end
