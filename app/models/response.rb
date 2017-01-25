class Response < ApplicationRecord
  validates_presence_of :answers, :on => :update

  belongs_to :form
  belongs_to :user
  belongs_to :classroom

  has_one :notification

  has_many :answers, dependent: :destroy

  validates_associated :answers

  attr_accessor :answers_attributes

  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
