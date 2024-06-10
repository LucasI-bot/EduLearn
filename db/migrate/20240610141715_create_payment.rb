class CreatePayment < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.belongs_to :inscription
      t.float :price
      
      t.timestamps
    end
  end
end
