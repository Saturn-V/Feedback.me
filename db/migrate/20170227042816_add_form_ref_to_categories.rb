class AddFormRefToCategories < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :form, foreign_key: true
  end
end
