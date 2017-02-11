class AddIndexAndUniqueToClassroomCode < ActiveRecord::Migration[5.0]
  def change
    add_index :classrooms, :class_code, :unique => true
  end
end
