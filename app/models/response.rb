class Response < ApplicationRecord
  # validates_presence_of :answers, :on => :update

  belongs_to :user
  belongs_to :classroom
  belongs_to :form

  has_one :notification, dependent: :destroy

  has_many :answers, dependent: :destroy

  # validates_associated :answers

  attr_accessor :answers_attributes

  accepts_nested_attributes_for :answers
end
