class Answer < ActiveRecord::Base
  attr_accessible :answer

  attr_accessor :not_cleanup

  belongs_to :question

  before_save :persian_cleanup, unless: :not_cleanup
  before_save :generate_md5_for_answer

  validates_presence_of :answer
  validates_uniqueness_of :answer, scope: :question_id, case_sensitive: false

  private

  def generate_md5_for_answer
    self.answer_md5 = Digest::MD5.hexdigest(self.answer)
  end

  def persian_cleanup
    self.answer = self.answer.persian_cleanup
  end
end
