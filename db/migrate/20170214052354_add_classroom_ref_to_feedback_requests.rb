class AddClassroomRefToFeedbackRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :feedback_requests, :classroom, foreign_key: true
  end
end
