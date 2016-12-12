class AddClassroomRefToForms < ActiveRecord::Migration[5.0]
  def change
    add_reference :forms, :classroom, foreign_key: true
  end
end
