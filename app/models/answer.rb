#encoding: utf-8

class Answer < ActiveRecord::Base
  attr_accessible :answer

  attr_accessor :cleanup

  belongs_to :question

  validates_presence_of :answer

  before_save :persian_cleanup, if: :cleanup
  before_save :make_non_standard, unless: :cleanup
  before_save :generate_md5_for_answer

  private

  def generate_md5_for_answer
    self.answer_md5 = Digest::MD5.hexdigest(self.answer)
  end

  def persian_cleanup
    self.answer = self.answer.persian_cleanup
  end

  def make_non_standard
      self.question.answers.create!({answer: to_non_standard(self.answer),
        cleanup: true}, without_protection: true)
  end

  def to_non_standard(text)
    # character replacement
    persian_numbers = "۱۲۳۴۵۶۷۸۹۰"
    arabic_numbers  = "١٢٣٤٥٦٧٨٩٠"
    english_numbers = "1234567890"
    bad_chars  = ",;كي%"
    good_chars = "،؛کی٪"
    text.tr!(persian_numbers,english_numbers)
    text.tr!(arabic_numbers,english_numbers)
    text.tr!(good_chars,bad_chars)
    text
  end
end
