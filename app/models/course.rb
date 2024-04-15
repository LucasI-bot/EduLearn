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
end
