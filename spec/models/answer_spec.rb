#encoding: utf-8

require 'spec_helper'

describe Answer do

  context "validations" do
    it {should validate_presence_of(:answer)}
  end

  context "relations" do
    it {should belong_to(:question)}
  end

  it 'should creates non standard answers' do
    question = Question.create(question: "test test test")
    answer = question.answers.create(answer: "غیر استاندارد است یی ک ک ک ۱ ۲۳")

    expect(Question.last).to eq(question)
    expect(Answer.count).to eq(2)
  end
end
