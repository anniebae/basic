class QuestionnaireController < ApplicationController

  def participant
    @participant ||= current_user
  end
end