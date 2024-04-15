module Teacher
  class Teacher::ExamAnswersController < Teacher::TeacherController
    def index
      if params[:course_id]
        @course = Course.find(params[:course_id])
        @exam_answers = ExamAnswer.joins(exam: { section: :course }).where(courses: { id: @course.id })
      else
        @exam_answers = ExamAnswer.joins(exam: { section: :course }).where(courses: { user_id: current_user.id })
      end

      case params[:order_by]
      when 'student'
        @exam_answers = @exam_answers.joins(:user).order(Arel.sql("COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)) " + params[:order]))
      when 'course'
        @exam_answers = @exam_answers.order("courses.title " + params[:order])
      when 'exam'
        @exam_answers = @exam_answers.order("exams.title " + params[:order])
      when 'date'
        @exam_answers = @exam_answers.order("exam_answers.created_at " + params[:order])
      end

    end

    def show
      @exam_answer = ExamAnswer.find(params[:id])
      if params[:course_id]
        @course = Course.find(params[:course_id])
      end
    end

    def update
      @exam_answer = ExamAnswer.find(params[:id])

      if @exam_answer.update(exam_answer_params)
        if params[:course_id]
          @course = Course.find(params[:course_id])
          redirect_to teacher_course_exam_answers_path(@course)
        else
          redirect_to teacher_exam_answers_path
        end
      else
        render :show
      end
    end

    private
    def exam_answer_params
      params.require(:exam_answer).permit(question_answers_attributes: [:id, :correct])
    end
  end
end
