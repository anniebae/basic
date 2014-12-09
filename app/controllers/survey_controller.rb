class SurveyController < ApplicationController

  def index
  end

  def participant
    @participant ||= current_user
  end

  def survey_score
    response_yes = survey.select { |question, response | response = "yes" }
    current_user.survey_score = response_yes * 3
    current_user.save!
    current_user.survey?
    redirect_to users_path
    # user.survey_score = (survey.select{ |question, response| response = "yes" }.length * 3)
  end





end