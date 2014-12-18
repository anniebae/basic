class SurveyController < ApplicationController
  def index
  end

  def participant
    @participant ||= current_user
  end
end