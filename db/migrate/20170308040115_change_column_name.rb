class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :questions_skills, :question_id, :competency_id
  end
end
