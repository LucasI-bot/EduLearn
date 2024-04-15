module Teacher
  class Teacher::QuestionsController < Teacher::TeacherController
    def new
      @question = Question.new()
      @exam = Exam.find_by_id(params[:exam_id])
      @question.question_type = params[:type]
      @question.question_number = params[:number]
      @question.options.build
    end

    def create
      @exam = Exam.find_by_id(params[:exam_id])
      @question = @exam.questions.new(question_params)

      if @question.save
        redirect_to teacher_course_section_exam_path(@exam.section.course, @exam.section, @exam)
      else
        render 'new'
      end
    end

    def edit
      @question = Question.find_by(id: params[:id])
    end

    def update
      @question = Question.find_by(id: params[:id])

      if @question.question_type == "multiple_choice"

        ids_options = []

        question_params[:options_attributes].each do |option|
          ids_options.append(option[1][:id].to_i)
        end

        @question.options.each do |option|
          unless ids_options.include?(option.id)
            option.destroy
          end
        end
      end

      if @question.update(question_params)
        redirect_to teacher_course_section_exam_path(@question.exam.section.course, @question.exam.section, @question.exam)
      else
        render 'edit'
      end
    end

    def destroy
    end

    private
      def question_params
        params.require(:question).permit(:question, :question_type, :question_number, :answer, options_attributes: [:id, :option, :correct])
      end
  end
end
