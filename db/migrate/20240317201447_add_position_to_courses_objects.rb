class AddPositionToCoursesObjects < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :position, :int
    add_column :lectures, :position, :int
    add_column :exams, :position, :int
  end
end
