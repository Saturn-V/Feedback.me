class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.boolean :free
      t.boolean :static
      t.string :option_one
      t.string :option_two
      t.string :option_three
      t.string :option_four
      t.string :option_five
      t.string :option_six

      t.timestamps
    end
  end
end
