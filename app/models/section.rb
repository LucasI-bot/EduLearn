class Section < ApplicationRecord
    belongs_to :course
    has_many :lectures, dependent: :destroy
    has_many :exams, dependent: :destroy
end
