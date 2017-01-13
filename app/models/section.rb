class Section < ApplicationRecord
  belongs_to :form
  belongs_to :question

  validates_presence_of :question
  validates_presence_of :form
  
  accepts_nested_attributes_for :question
end
