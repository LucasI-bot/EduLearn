class AddQuestionNumberToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :question_number, :integer
  end
end
