class CreateFeedbackRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :feedback_requests do |t|

      t.timestamps
    end
  end
end
