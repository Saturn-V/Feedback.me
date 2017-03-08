class Answer < ApplicationRecord
  belongs_to :response
  belongs_to :competency

  scope :for_static, -> { joins(:competency).where(competencies: { static: true, free: false }) }
end
