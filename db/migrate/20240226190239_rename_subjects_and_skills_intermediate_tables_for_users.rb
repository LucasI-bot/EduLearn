class RenameSubjectsAndSkillsIntermediateTablesForUsers < ActiveRecord::Migration[7.0]
  def change
    rename_table :users_subjects, :subjects_users
    rename_table :users_skills, :skills_users
  end
end
