class Classroom < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_and_belongs_to_many :users
  has_and_belongs_to_many :forms

  has_many :feedback_requests, dependent: :destroy

  def self.search(search)
    where("class_code LIKE ?", "%#{search}%")
  end

  # scope :students, -> (classroom) { classroom.users.where(student: true) }

  def enable_graph
    months = []
    self.responses.each do |response|
      month = response.created_at.to_datetime.month
      unless months.include?(month)
        months.append(month)
      end
        return true if months.count >= 6
    end
    return false
  end

  def instructor
    self.users.where(instructor: true).first
  end

  def students
    self.users.where(student: true)
  end
end
