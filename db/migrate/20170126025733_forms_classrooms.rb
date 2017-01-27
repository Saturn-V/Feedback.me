class FormsClassrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms_classrooms, id: false do |t|
      t.belongs_to :form, index: true
      t.belongs_to :classroom, index: true
    end
  end
end
