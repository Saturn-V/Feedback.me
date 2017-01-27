class Classroom < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_and_belongs_to_many :users
  has_and_belongs_to_many :forms

  def self.search(search)
    where("class_code LIKE ?", "%#{search}%")
  end
end
