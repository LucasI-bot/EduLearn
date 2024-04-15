class ExamAnswer < ApplicationRecord
  belongs_to :exam
  belongs_to :user
  has_many :question_answers
  
  accepts_nested_attributes_for :question_answers
end
