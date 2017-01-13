class AddResponseRefToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :notifications, :response, foreign_key: true
  end
end
