class CreateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :skills do |t|
      t.string :skill, null: false

      t.timestamps
    end

    create_table :skills_courses do |t|
      t.belongs_to :skill
      t.belongs_to :course

      t.timestamps
    end

    create_table :skills_users do |t|
      t.belongs_to :skill
      t.belongs_to :user

      t.timestamps
    end
  end
end
