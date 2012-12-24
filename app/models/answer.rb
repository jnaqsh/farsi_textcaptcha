class Answer < ActiveRecord::Base
  attr_accessible :answer, :answer_md5

  belongs_to :question

  validates_presence_of :answer

  before_save :generate_md5_for_answer

  private

  def generate_md5_for_answer
    self.answer_md5 = Digest::MD5.hexdigest(self.answer)
  end
end
