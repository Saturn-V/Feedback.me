class AddUserRefToForms < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :created_by_id, :integer
    add_index :forms, :created_by_id
  end
end
