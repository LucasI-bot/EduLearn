class RenameSubjectsAndSkillsIntermediateTables < ActiveRecord::Migration[7.0]
  def change
    rename_table :subjects_courses, :courses_subjects
    rename_table :subjects_users, :users_subjects
    rename_table :skills_courses, :courses_skills
    rename_table :skills_users, :users_skills
  end
end
