class AddMarkToExamAnswer < ActiveRecord::Migration[7.0]
  def change
    add_column :exam_answers, :mark, :float
  end
end
