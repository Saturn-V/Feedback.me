class Classroom < ApplicationRecord
  has_many :forms
  has_and_belongs_to_many :users
end
