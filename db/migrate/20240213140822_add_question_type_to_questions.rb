class AddQuestionTypeToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :question_type, :integer
  end
end
