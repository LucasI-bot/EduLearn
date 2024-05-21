class AddActiveToExamAnswer < ActiveRecord::Migration[7.0]
  def change
    add_column :exam_answers, :active, :boolean
  end
end
