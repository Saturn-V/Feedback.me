class RemoveFormFromQuestions < ActiveRecord::Migration[5.0]
  def change
    remove_reference :questions, :form, foreign_key: true
  end
end
