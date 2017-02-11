class AddCascadeDeleteToFormRelationships < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :questions, :forms
    add_foreign_key :questions, :forms, on_delete: :cascade
  end
end
