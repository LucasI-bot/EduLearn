class Exam < ApplicationRecord
    belongs_to :section, optional: true
    has_many :questions, dependent: :destroy
    has_many :exam_answers, dependent: :destroy
end
