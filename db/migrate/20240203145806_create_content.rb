class CreateContent < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.integer :type
      t.string :text
      t.belongs_to :lecture


      t.timestamps
    end
  end
end
