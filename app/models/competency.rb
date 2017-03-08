class Competency < ApplicationRecord
  belongs_to :category, optional: true

  has_many :answers, dependent: :destroy

  has_and_belongs_to_many :skills, inverse_of: :competency
  accepts_nested_attributes_for :skills, allow_destroy: true, :reject_if => lambda { |a| a[:label].blank? }

  validates :label, :presence => true
end
