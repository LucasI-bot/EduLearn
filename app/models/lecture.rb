class Lecture < ApplicationRecord
    belongs_to :section, optional: true
    belongs_to :course, optional: true

    has_many :contents
end
