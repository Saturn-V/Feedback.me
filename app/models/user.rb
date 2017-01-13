class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :classrooms
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_many :responses, dependent: :destroy
end
