class FeedbackRequest < ApplicationRecord

  belongs_to :form
  belongs_to :user
  belongs_to :classroom

  has_many :responses, dependent: :destroy do
    def instructor_performance
      performance_score = 0
      self.each do |response|
        if response.is_complete
          answers = response.answers.for_static
          response_score = 0
          answers.each do |answer|
            response_score += answer.value_static
          end
          response_score = response_score / answers.count
          performance_score += response_score
        end
      end

      return performance_score
    end
  end
end
