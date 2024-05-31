class User < ApplicationRecord
    before_save :downcase_email

    has_and_belongs_to_many :skills
    has_and_belongs_to_many :subjects

    has_secure_password

    has_many :courses
    has_many :inscriptions
    has_many :conversations
    has_many :exam_answers

    has_one_attached :picture

    enum role: %i[student teacher]

    validates :email, presence: true, uniqueness: true

    scope :by_name, -> (q) { where("lower(COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)))  LIKE ?", "%#{q}%") }
    scope :by_subject_ids, -> (q) { joins(courses: :subjects).where(courses: { subjects: {id: q } }).group('users.id') }
    scope :by_skill_ids, -> (q) { joins(courses: :skills).where(courses: { skills: {id: q } }).group('users.id') }
    scope :by_course_id, -> (q) { joins(:inscriptions).where(inscriptions: {paid: true, approved: true, course_id: q }) }

    private

    def downcase_email
        self.email = email.downcase
    end
end
