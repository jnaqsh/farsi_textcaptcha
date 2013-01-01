class Answer < ActiveRecord::Base
  attr_accessible :answer

  attr_accessor :not_cleanup

  belongs_to :question

  before_validation :persian_cleanup, unless: :not_cleanup
  before_validation :generate_md5_for_answer

  validates_presence_of :answer
  validates_uniqueness_of :answer, scope: :question_id, case_sensitive: false
  validates_uniqueness_of :answer_md5, scope: :question_id, case_sensitive: false
  validates_length_of :answer, maximum: 50

  private

  def generate_md5_for_answer
    self.answer_md5 = Digest::MD5.hexdigest(self.answer)
  end

  def persian_cleanup
    self.answer = self.answer.persian_cleanup
  end
end
