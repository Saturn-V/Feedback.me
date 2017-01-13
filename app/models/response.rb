class Response < ApplicationRecord
  belongs_to :form
  belongs_to :user

  has_one :notification

  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

end
