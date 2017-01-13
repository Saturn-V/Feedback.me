class AddFieldsToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :value_static, :int
    add_column :answers, :value_free, :string
  end
end
