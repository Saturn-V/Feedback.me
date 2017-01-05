class AddInstructorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :instructor, :boolean, default: true
  end
end
