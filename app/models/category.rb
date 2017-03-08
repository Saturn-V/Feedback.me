class Category < ApplicationRecord
    belongs_to :form, optional: true

    has_many :competencies, dependent: :destroy
    accepts_nested_attributes_for :competencies, allow_destroy: true, :reject_if => lambda { |a| a[:label].blank? }
end
