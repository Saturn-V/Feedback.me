class AddFormRefToResponses < ActiveRecord::Migration[5.0]
  def change
    add_reference :responses, :form, foreign_key: true
  end
end
