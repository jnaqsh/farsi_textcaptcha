class Question < ActiveRecord::Base
  attr_accessible :approved, :question, :answers_attributes

  has_many :answers

  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:answer].blank? },
    :allow_destroy => true

  validates_presence_of :question
  validates_length_of :question, minimum: 10, maximum: 150
  validates_uniqueness_of :question, case_sensitive: false

  scope :approved, where(approved: true)
  scope :unapproved, where(approved: false)

  before_save :persian_cleanup

  def self.random
    Question.approved.offset(rand(Question.approved.count)).first
  end

  def approve
    update_attributes approved: true
  end

  private

  def persian_cleanup
    self.question = self.question.persian_cleanup.strip
  end
end
