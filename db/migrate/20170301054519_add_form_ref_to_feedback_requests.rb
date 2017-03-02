class AddFormRefToFeedbackRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :feedback_requests, :form, foreign_key: true
  end
end
