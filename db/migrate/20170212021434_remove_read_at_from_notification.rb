class RemoveReadAtFromNotification < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :read_at
  end
end
