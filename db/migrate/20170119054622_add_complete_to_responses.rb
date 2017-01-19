class AddCompleteToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :complete, :boolean, default: false
  end
end
