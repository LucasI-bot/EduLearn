class Question < ApplicationRecord
    belongs_to :exam
    has_many :options
    accepts_nested_attributes_for :options

    enum question_type: %i[multiple_choice file_upload question_answer]
end
