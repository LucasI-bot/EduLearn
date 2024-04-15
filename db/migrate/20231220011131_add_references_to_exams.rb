class AddReferencesToExams < ActiveRecord::Migration[7.0]
  def change
    add_reference :exams, :course
    add_reference :exams, :section
  end
end
