class AddReferenceToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :exam, foreign_key: true
  end
end
