module Student
  class Student::ExamsController < Student::StudentController
    def index
      @course = Course.find(params[:course_id])
      @inscription = Inscription.where(user_id: current_user.id, course_id: params[:course_id]).first
      @exams = Exam.where(section_id: @course.sections.map{|a| a.id})
    end

    def show
      @exam = Exam.find(params[:id])
      @exam_answer = current_user.exam_answers.where(finished: true, active: true, exam_id: params[:id]).first
    end

    def create
      @exam = Exam.find(params[:id])

      if current_user.exam_answers.where(exam_id: params[:id], active: true, finished: false).first.present?
        redirect_to student_course_exam_question_path(@exam.section.course, @exam, 1)
      else

        current_user.exam_answers.where(exam_id: params[:id], active: true, finished: true).update_all(active: false)

        @exam_answer = ExamAnswer.new()

        @exam_answer.exam_id = @exam.id
        @exam_answer.user_id = current_user.id
        @exam_answer.finished = false
        @exam_answer.active = true

        if @exam_answer.save
          @exam.questions.order(question_number: :asc).map{|a| a.question_number}.uniq.each do |number|
            @question = Question.where(question_number: number, exam_id: @exam.id).order("RANDOM()").limit(1).first

            @question_answer = @exam_answer.question_answers.new
            @question_answer.question_id = @question.id
            @question_answer.question_number = number

            if @question_answer.save
              if @question.question_type = "multiple_choice"
                @question.options.each do |option|
                  @option_answer = @question_answer.option_answers.new

                  @option_answer.option_id = option.id

                  if !@option_answer.save
                    print("Error en opciones")
                    redirect_to student_course_exam_path(@exam.section.course, @exam)
                  end
                end
              end
            else
              print("Error en Preguntas")
              redirect_to student_course_exam_path(@exam.section.course, @exam)
            end
          end
          redirect_to student_course_exam_question_path(@exam.section.course, @exam, 1)
        else
          print("Error en Evaluación")
          redirect_to student_course_exam_path(@exam.section.course, @exam)
        end
      end

    end
  end
end
