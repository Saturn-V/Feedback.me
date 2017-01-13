class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.boolean :static
      t.boolean :free
      t.string :label

      t.timestamps
    end
  end
end
