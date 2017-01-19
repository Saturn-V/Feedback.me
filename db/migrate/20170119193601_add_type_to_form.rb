class AddTypeToForm < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :assesment_type, :string
  end
end
