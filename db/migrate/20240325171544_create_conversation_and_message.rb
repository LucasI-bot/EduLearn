class CreateConversationAndMessage < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.belongs_to :teacher, class_name: :user
      t.belongs_to :student, class_name: :user

      t.timestamps
    end

    create_table :messages do |t|
      t.belongs_to :conversation
      t.belongs_to :user
      t.string :message
      
      t.timestamps
    end
  end
end
