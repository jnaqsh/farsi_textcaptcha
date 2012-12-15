class Question < ActiveRecord::Base
  attr_accessible :approved, :question, :answers_attributes

  has_many :answers

  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:answer].blank? },
    :allow_destroy => true
end
