class ExamAnswer < ApplicationRecord
  belongs_to :exam
  belongs_to :user
  has_many :question_answers, dependent: :destroy

  scope :by_name, -> (q) { joins(:user).where("lower(COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)))  LIKE ?", "%#{q}%") }
  scope :by_course_id, -> (q) { joins(exam: :section).where(section: { course_id: q }) }
  scope :by_exam, -> (q) { joins(:exam).where("lower(exams.title) LIKE ?", "%#{q}%") }

  accepts_nested_attributes_for :question_answers
end
