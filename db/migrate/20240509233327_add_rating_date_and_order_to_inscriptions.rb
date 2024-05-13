class AddRatingDateAndOrderToInscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :inscriptions, :order, :float
    add_column :inscriptions, :rating_date, :datetime
  end
end
