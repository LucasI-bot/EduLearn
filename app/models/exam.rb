class Exam < ApplicationRecord
    belongs_to :course, optional: true
    belongs_to :section
    has_many :questions
    has_many :exam_answers
end
