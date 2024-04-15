class User < ApplicationRecord
    before_save :downcase_email

    has_and_belongs_to_many :skills
    has_and_belongs_to_many :subjects

    has_secure_password

    has_many :courses
    has_many :inscriptions
    has_many :conversations

    has_one_attached :picture

    enum role: %i[student teacher]

    validates :email, presence: true, uniqueness: true

    private

    def downcase_email
        self.email = email.downcase
    end
end
