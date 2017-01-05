class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :classrooms
  after_create :assign_student_role
  attr_writer :current_step

  def assign_student_role
    # if self.classroom_id
      # self.update_attribute :instructor, false
      # self.update_attribute :student, true
    # end
  end

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[class_code student teacher]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end
end
