class AddQuestionNumberToQuestionAnswer < ActiveRecord::Migration[7.0]
  def change
    add_column :question_answers, :question_number, :integer
  end
end
