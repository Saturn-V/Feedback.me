class Response < ApplicationRecord
  validates_presence_of :answers, :on => :update

  belongs_to :form
  belongs_to :user
  belongs_to :classroom

  has_one :notification

  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

end
