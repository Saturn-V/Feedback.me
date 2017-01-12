class FormsQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_questions, id: false do |t|
      t.belongs_to :form, index: true
      t.belongs_to :question, index: true
    end
  end
end
