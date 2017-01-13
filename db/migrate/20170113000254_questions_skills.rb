class QuestionsSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_skills, id: false do |t|
      t.belongs_to :question, index: true
      t.belongs_to :skill, index: true
    end
  end
end
