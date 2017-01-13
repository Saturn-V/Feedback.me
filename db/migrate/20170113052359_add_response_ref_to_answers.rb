class AddResponseRefToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_reference :answers, :response, foreign_key: true
  end
end
