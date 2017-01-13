class Question < ApplicationRecord
  belongs_to :form
  has_and_belongs_to_many :skills
end
