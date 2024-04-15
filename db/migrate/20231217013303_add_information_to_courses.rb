class AddInformationToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :price, :float
    add_column :courses, :start_date, :datetime
    add_column :courses, :end_date, :datetime
    add_column :courses, :inscription_start_date, :datetime
    add_column :courses, :inscription_end_date, :datetime
    add_column :courses, :visibility, :boolean
    add_column :courses, :acceptance_required, :boolean
    add_reference :courses, :user, foreign_key: true
  end
end
