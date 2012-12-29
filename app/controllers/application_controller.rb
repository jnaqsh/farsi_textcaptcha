class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_number_of_approved_questions

  private

  def load_number_of_approved_questions
    @number_of_approved_questions = Question.approved.count
  end
end
