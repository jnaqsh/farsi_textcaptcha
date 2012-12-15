class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer
      t.string :answer_md5
      t.integer :question_id

      t.timestamps
    end
  end
end
