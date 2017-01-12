class Form < ApplicationRecord
  belongs_to :classroom
  has_and_belongs_to_many :questions
end
