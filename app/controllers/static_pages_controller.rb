class StaticPagesController < ApplicationController
  skip_before_filter :authorize

  def home
    @question = Question.demo_question
  end

  def really
  end

  def demo
    @questions = []
    5.times {@questions << Question.demo_question}
  end

  def how_it_works
  end

  def api
  end

  def why
  end
end
