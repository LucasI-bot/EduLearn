class AddRatingAndMarkOfUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :inscriptions, :mark, :float
    add_column :inscriptions, :rating, :int
    add_column :inscriptions, :review, :string
    add_column :courses, :rating, :float
    add_column :inscriptions, :inscription_date, :datetime
  end
end
