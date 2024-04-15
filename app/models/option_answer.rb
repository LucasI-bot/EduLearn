class OptionAnswer < ApplicationRecord
  belongs_to :question_answer
  belongs_to :option
end
