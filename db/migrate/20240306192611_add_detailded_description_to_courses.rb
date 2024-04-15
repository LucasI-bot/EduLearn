class AddDetaildedDescriptionToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :detailed_description, :string
  end
end
