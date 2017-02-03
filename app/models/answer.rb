class Answer < ApplicationRecord
  belongs_to :response
  belongs_to :question

  scope :for_static, -> { joins(:question).where(questions: { static: true, free: false }) }
end
