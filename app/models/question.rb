class Question < ActiveRecord::Base
  attr_accessible :approved, :question, :answers_attributes

  has_many :answers

  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:answer].blank? },
    :allow_destroy => true

  validates_presence_of :question
  validates_length_of :question, minimum: 10, maximum: 50

  scope :approved, where(approved: true)
  scope :unapproved, where(approved: false)

  def self.random
    Question.offset(rand(Question.count)).first
  end
end
