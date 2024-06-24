module Student
  class Student::QuestionsController < Student::StudentController
    def edit
      @exam_answer = ExamAnswer.where(exam_id: params[:exam_id], finished: false, active: true).first
      @question_answer = @exam_answer.question_answers.where(question_number: params[:number]).first
    end

    def update
      @exam_answer = ExamAnswer.where(exam_id: params[:exam_id], finished: false, active: true).first
      @question_answer = @exam_answer.question_answers.where(question_number: params[:number]).first

      if @question_answer.update(question_answer_params)
        if params[:question_number]
          redirect_to student_course_exam_question_path(@exam_answer.exam.section.course, @exam_answer.exam, params[:question_number])
        else
          @exam_answer.finished = true
          @exam_answer.question_answers.each do |question_answer|
            case question_answer.question.question_type
            when "question_answer"
              if question_answer.answer.present?
                if question_answer.question.answer.blank?
                  @exam_answer.mark = -1
                elsif question_answer.question.answer.downcase.gsub(/\s+/, "") == question_answer.answer.downcase.gsub(/\s+/, "")
                  question_answer.correct = true
                  question_answer.save
                else
                  question_answer.correct = false
                  question_answer.save
                end
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

          if @exam_answer.mark == -1
            @exam_answer.mark = 0
          else
            @exam_answer.mark = 10 * @exam_answer.question_answers.where(correct: true).count.to_f / @exam_answer.question_answers.count.to_f
            if @exam_answer.mark == 0
              @exam_answer.mark = 1
            end
          end

          @exam_answer.save

          redirect_to student_course_exam_path(@exam_answer.exam.section.course, @exam_answer.exam)
        end
      else
        render :edit
      end
    end

    private
      def question_answer_params
        params.require(:question_answer).permit(:answer, :file, option_answers_attributes: [:id, :selected])
      end
  end
end
