class Question < ApplicationRecord
    belongs_to :exam
    has_many :options, dependent: :destroy
    accepts_nested_attributes_for :options

    validate :accepted_multiple_choice

    def accepted_multiple_choice
        if question_type == 'multiple_choice'
            unless options.to_a.count > 1
                errors.add(:options, "La pregunta debe tener al menos 2 opciones")
            end
        end
    end

    enum question_type: %i[multiple_choice file_upload question_answer]
end
