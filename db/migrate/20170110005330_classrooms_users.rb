class ClassroomsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :classrooms_users, id: false do |t|
      t.belongs_to :classroom, index: true
      t.belongs_to :user, index: true
    end
  end
end
