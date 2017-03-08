class RenameQuestionsSkillsToCompetenciesSkills < ActiveRecord::Migration[5.0]
  def change
    rename_table :questions_skills, :competencies_skills
  end
end
