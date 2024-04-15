class Conversation < ApplicationRecord
  belongs_to :student, foreign_key: :student_id, class_name: :User
  belongs_to :teacher, foreign_key: :teacher_id, class_name: :User
  has_many :messages
end
