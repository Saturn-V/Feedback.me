class ChangeColumnNameInAnswers < ActiveRecord::Migration[5.0]
  def change
    rename_column :answers, :question_id, :competency_id
  end
end
