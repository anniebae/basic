class AddDefaultValueToSurveyScore < ActiveRecord::Migration
  def change
    change_column :users, :survey_score, :integer, :default => 0
  end
end