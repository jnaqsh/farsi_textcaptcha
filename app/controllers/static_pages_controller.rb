class StaticPagesController < ApplicationController
  def home
    @question = Question.random
  end

  def really
  end

  def demo
    @questions = Question.random(5)
  end

  def how_it_works
  end

  def api
  end

  def why
  end
end
