class AddReferencesToLectures < ActiveRecord::Migration[7.0]
  def change
    add_reference :lectures, :section
  end
end
