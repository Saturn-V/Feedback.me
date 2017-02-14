class AddFeedbackRequestRefToResponses < ActiveRecord::Migration[5.0]
  def change
    add_reference :responses, :feedback_request, foreign_key: true
  end
end
