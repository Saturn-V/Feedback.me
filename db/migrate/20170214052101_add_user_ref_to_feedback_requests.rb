class AddUserRefToFeedbackRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :feedback_requests, :user, foreign_key: true
  end
end
