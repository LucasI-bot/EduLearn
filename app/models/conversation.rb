class Conversation < ApplicationRecord
  belongs_to :student, foreign_key: :student_id, class_name: :User
  belongs_to :teacher, foreign_key: :teacher_id, class_name: :User

  scope :by_name, -> (q) { joins(:student).where("lower(COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)))  LIKE ?", "%#{q}%") }
  scope :by_course_id, -> (q) { joins(student: :inscriptions).where(users: { inscriptions: {paid: true, approved: true, course_id: q } }) }

  has_many :messages
end
