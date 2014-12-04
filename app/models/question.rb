class Question < ActiveRecord::Base
  belongs_to :questionnaire
  has_many :answers
  has_many :responses, :through => :answers
end