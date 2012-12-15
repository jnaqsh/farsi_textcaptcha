class Answer < ActiveRecord::Base
  attr_accessible :answer, :answer_md5, :question_id
end
