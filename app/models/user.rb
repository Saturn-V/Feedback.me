class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :access_code
  validate :access_code_valid, :on => :create

  has_and_belongs_to_many :classrooms

  # Students receive many notifications from instructors
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy

  # Students "create" (update) their responses
  has_many :responses, dependent: :destroy

  has_many :feedback_requests, dependent: :destroy

  # attr_accessor :password, :password_confirmation

  # def self.valid_email?(email)
  #   if User.exists?(email: email)
  #     return true
  #   end
  #   return false
  # end

  def access_code_valid
    # MakeSchoolClass18
    unless self.access_code == "uiux"
      self.errors.add(:access_code, "Invalid Beta Access Code.")
    end
  end
end
