class Section < ApplicationRecord
    belongs_to :course
    has_many :lectures
    has_many :exams
end
