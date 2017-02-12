class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :response

  scope :incomplete, -> { joins(:response).where(responses: { is_complete: false }) }
  scope :completed, -> { joins(:response).where(responses: { is_complete: true }) }
end
