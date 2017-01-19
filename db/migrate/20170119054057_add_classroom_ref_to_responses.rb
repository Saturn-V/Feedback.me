class AddClassroomRefToResponses < ActiveRecord::Migration[5.0]
  def change
    add_reference :responses, :classroom, foreign_key: true
  end
end
