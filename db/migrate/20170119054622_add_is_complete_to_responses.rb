class AddIsCompleteToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :is_complete, :boolean, default: false
  end
end
