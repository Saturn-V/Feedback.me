class Answer < ApplicationRecord
  belongs_to :response
  belongs_to :question

  accepts_nested_attributes_for :response
end
