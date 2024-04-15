class CreateExamAnswerAndQuestionAnswer < ActiveRecord::Migration[7.0]
  def change
    create_table :exam_answers do |t|
      t.belongs_to :user
      t.belongs_to :exam
      t.boolean :finished

      t.timestamps
    end

    create_table :question_answers do |t|
      t.belongs_to :exam_answer
      t.belongs_to :question
      t.string :answer

      t.timestamps
    end

    create_table :option_answers do |t|
      t.belongs_to :question_answer
      t.belongs_to :option

      t.timestamps
    end
  end
end
