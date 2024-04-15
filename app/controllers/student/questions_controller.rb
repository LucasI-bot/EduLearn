module Student
  class Student::QuestionsController < Student::StudentController
    def edit
      @exam_answer = ExamAnswer.where(exam_id: params[:exam_id], finished: false).first
      @question_answer = @exam_answer.question_answers.where(question_number: params[:number]).first
    end

    def update
      @exam_answer = ExamAnswer.where(exam_id: params[:exam_id], finished: false).first
      @question_answer = @exam_answer.question_answers.where(question_number: params[:number]).first

      if @question_answer.update(question_answer_params)
        if @exam_answer.question_answers.count == @question_answer.question_number
          @exam_answer.finished = true
          @exam_answer.question_answers.each do |question_answer|
            case question_answer.question.question_type
            when "question_answer"
              if question_answer.question.answer.blank?
                @exam_answer.mark = -1
              elsif question_answer.question.answer.downcase.gsub(/\s+/, "") == question_answer.answer.downcase.gsub(/\s+/, "")
                question_answer.correct = true
                question_answer.save
              else
                question_answer.correct = false
                question_answer.save
              end
            when "multiple_choice"
              question_answer.option_answers.each do |option_answer|
                unless option_answer.selected == option_answer.option.correct
                  question_answer.correct = false
                end
              end
              if question_answer.correct != false
                question_answer.correct = true
              end
              question_answer.save
            when "file_upload"
              @exam_answer.mark = -1
            end
          end

          unless @exam_answer.mark == -1
            @exam_answer.mark = 100 * @exam_answer.question_answers.where(correct: true).count / @exam_answer.question_answers.count
          end

          @exam_answer.save

          redirect_to student_course_exam_questions_path(@exam_answer.exam.section.course, @exam_answer.exam)
        else
          redirect_to student_course_exam_question_path(@exam_answer.exam.section.course, @exam_answer.exam, (@question_answer.question_number + 1))
        end
      else
        render :edit
      end
    end

    def index
      @exam_answer = ExamAnswer.order(mark: :desc).first
    end

    private
      def question_answer_params
        params.require(:question_answer).permit(:answer, :file, option_answers_attributes: [:id, :selected])
      end
  end
end
