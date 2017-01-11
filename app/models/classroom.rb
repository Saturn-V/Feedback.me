class Classroom < ApplicationRecord
  has_many :forms
  has_and_belongs_to_many :users

  def self.search(search)
    where("class_code LIKE ?", "%#{search}%")
  end
end
