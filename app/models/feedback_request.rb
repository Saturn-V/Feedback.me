class FeedbackRequest < ApplicationRecord
  has_many :responses, dependent: :destroy
  belongs_to :user
  belongs_to :classroom
end
