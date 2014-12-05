class SurveyController < ApplicationController

  def index
  end

  def participant
    @participant ||= current_user
  end




  def survey_score
    response_yes = survey.select { |question, response | response = "yes" }
    user.survey_score = response_yes * 3
    user.save!

    # user.survey_score = (survey.select{ |question, response| response = "yes" }.length * 3)
  end


end