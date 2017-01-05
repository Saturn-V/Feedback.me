class CreateJoinTableClassroomsUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :classrooms, :users do |t|
      t.index :classroom_id
      t.index :user_id
    end
  end
end
