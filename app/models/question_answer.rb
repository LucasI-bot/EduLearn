class QuestionAnswer < ApplicationRecord
  belongs_to :exam_answer
  belongs_to :question
  has_many :option_answers

  accepts_nested_attributes_for :option_answers

  has_one_attached :file
end
