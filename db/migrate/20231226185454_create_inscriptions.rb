class CreateInscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :inscriptions do |t|
      t.boolean :approved
      t.boolean :paid
      t.belongs_to :user
      t.belongs_to :course
      t.timestamps
    end
  end
end
