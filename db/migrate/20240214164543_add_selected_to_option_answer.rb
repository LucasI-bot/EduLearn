class AddSelectedToOptionAnswer < ActiveRecord::Migration[7.0]
  def change
    add_column :option_answers, :selected, :boolean
  end
end
