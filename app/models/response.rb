class Response < ApplicationRecord
  # validates_presence_of :answers, :on => :update

  belongs_to :user
  belongs_to :classroom
  belongs_to :form

  has_one :notification, dependent: :destroy

  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true

  # validates_associated :answers

  scope :for_instructors, -> { joins(:form).where(is_complete: true, created_at: Time.now.end_of_month - 6.months..Time.now.end_of_month, forms: {assesment_type: 'instructor'}) }
end 
