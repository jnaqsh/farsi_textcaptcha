class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
