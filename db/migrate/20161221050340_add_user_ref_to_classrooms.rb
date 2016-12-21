class AddUserRefToClassrooms < ActiveRecord::Migration[5.0]
  def change
    add_reference :classrooms, :user, foreign_key: true
  end
end
