module Teacher
  class Teacher::QuestionsController < Teacher::TeacherController
    def new
      @mycourses = "active"

      @question = Question.new()
      @exam = Exam.find_by_id(params[:exam_id])
      @question.question_type = params[:type]
      @question.question_number = params[:number]
      2.times { @question.options.build }
    end

    def create
      @exam = Exam.find_by_id(params[:exam_id])
      @question = @exam.questions.new(question_params)

      if @question.save
        redirect_to teacher_course_section_exam_path(@exam.section.course, @exam.section, @exam)
      else
        flash.now[:alert] = @question.errors
        render 'new'
      end
    end

    def edit
      @mycourses = "active"
      
      @question = Question.find_by(id: params[:id])
    end

    def update
      @question = Question.find_by(id: params[:question_id])

      if @question.question_type == "multiple_choice"

        ids_options = []

        question_params[:options_attributes].each do |option|
          ids_options.append(option[1][:id].to_i)
        end

        if ids_options.count < 2
          flash.now[:alert] = "La pregunta debe tener al menos 2 opciones"
          render 'edit'
        else
          @question.options.each do |option|
            unless ids_options.include?(option.id)
              option.destroy
            end
          end

          if @question.update(question_params)
            redirect_to teacher_course_section_exam_path(@question.exam.section.course, @question.exam.section, @question.exam)
          else
            flash.now[:alert] = @question.errors
            render 'edit'
          end
        end
      else
        if @question.update(question_params)
          redirect_to teacher_course_section_exam_path(@question.exam.section.course, @question.exam.section, @question.exam)
        else
          flash.now[:alert] = @question.errors
          render 'edit'
        end
      end
    end

    def destroy
      @exam = Exam.find(params[:exam_id])
      @question = Question.find(params[:id])

      @question.destroy

      redirect_to teacher_course_section_exam_path(@exam.section.course, @exam.section, @exam)
    end

    private
      def question_params
        params.require(:question).permit(:question, :question_type, :question_number, :answer, options_attributes: [:id, :option, :correct])
      end
  end
end
