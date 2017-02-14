class Form < ApplicationRecord
  has_and_belongs_to_many :classrooms

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true, :reject_if => lambda { |a| a[:label].blank? }

  has_many :responses, dependent: :destroy

  validates :name, :assesment_type, :presence => true
end
