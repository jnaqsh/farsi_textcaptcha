class Question < ActiveRecord::Base
  attr_accessible :approved, :question, :answers_attributes

  has_many :answers

  accepts_nested_attributes_for :answers, :allow_destroy => true

  validates_presence_of :question
  validates_length_of :question, minimum: 10, maximum: 150
  validates_uniqueness_of :question, case_sensitive: false
  validate :must_have_at_least_one_answer

  scope :approved, where(approved: true)
  scope :unapproved, where(approved: false)

  before_validation :persian_cleanup

  def self.random(number=nil)
    if number
      Question.approved.offset(rand(Question.approved.count)).limit(number)
    else
      Question.approved.offset(rand(Question.approved.count)).first
    end
  end

  def approve
    update_attributes approved: true
  end

  private

  def must_have_at_least_one_answer
    if answers.empty? or answers.all? {|answer| answer.marked_for_destruction? }
      errors.add(:base, 'Must have at least one answer')
    end
  end

  def persian_cleanup
    self.question = self.question.persian_cleanup.strip
  end
end
