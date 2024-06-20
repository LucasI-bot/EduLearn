class Course < ApplicationRecord
    belongs_to :user
    has_many :sections
    has_many :lectures
    has_many :exams
    has_many :inscriptions
    has_and_belongs_to_many :skills
    has_and_belongs_to_many :subjects
    has_one_attached :banner_img
    has_many :users, :through => :inscriptions

    scope :by_title, -> (q) { where("lower(courses.title) LIKE ?", "%#{q}%") }
    scope :by_teacher, -> (q) { joins(:user).where("lower(COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)))  LIKE ?", "%#{q}%") }
    scope :by_acceptance, -> (q) { where(acceptance_required: q) }
    scope :by_subject_ids, -> (q) { joins(:subjects).where(subjects: {id: q }).group('courses.id').having('COUNT(DISTINCT subjects.id) = ?', q.size) }
    scope :by_skill_ids, -> (q) { joins(:skills).where(skills: {id: q }).group('courses.id').having('COUNT(DISTINCT skills.id) = ?', q.size) }
end
