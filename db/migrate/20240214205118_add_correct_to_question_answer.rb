class AddCorrectToQuestionAnswer < ActiveRecord::Migration[7.0]
  def change
    add_column :question_answers, :correct, :boolean
  end
end
