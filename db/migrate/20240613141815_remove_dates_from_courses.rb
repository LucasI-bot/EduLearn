class RemoveDatesFromCourses < ActiveRecord::Migration[7.0]
  def change
    remove_column :courses, :start_date
    remove_column :courses, :end_date
    remove_column :courses, :inscription_start_date
    remove_column :courses, :inscription_end_date
  end
end
