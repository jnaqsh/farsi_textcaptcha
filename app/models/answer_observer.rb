#encoding: utf-8

class AnswerObserver < ActiveRecord::Observer
  observe :answer

  def after_save(record)
    non_std_ans = to_non_standard(record.answer)
    if non_std_ans != record.answer.persian_cleanup
      Answer.create({answer: non_std_ans, question_id: record.question_id, not_cleanup: true},
        without_protection: true)
    end
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
