module Teacher
  class Teacher::ExamAnswersController < Teacher::TeacherController
    def index
      if params[:course_id].present?
        @mycourses = "active"

        @course = Course.find(params[:course_id])
        @exam_answers = ExamAnswer.joins(exam: { section: :course }).where(finished: true, active: true, courses: { id: @course.id })
      else
        @myexams = "active"

        @exam_answers = ExamAnswer.joins(exam: { section: :course }).where(finished: true, active: true, courses: { user_id: current_user.id })
      end

      if params[:name].present?
        @exam_answers = @exam_answers.by_name(params[:name].downcase)
      end

      if params[:course].present?
        @exam_answers = @exam_answers.by_course_id(params[:course].downcase)
      end

      if params[:exam].present?
        @exam_answers = @exam_answers.by_exam(params[:exam].downcase)
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
      when 'mark'
        @exam_answers = @exam_answers.order("exam_answers.mark " + params[:order])
      end

    end

    def show
      @exam_answer = ExamAnswer.find(params[:id])
      if params[:course_id].present?
        @mycourses = "active"

        @course = Course.find(params[:course_id])
      else
        @myexams = "active"
      end
    end

    def update
      @exam_answer = ExamAnswer.find(params[:id])

      if @exam_answer.update(exam_answer_params)
        unless @exam_answer.question_answers.where(correct: nil).count > 0
          @exam_answer.mark = 10 * @exam_answer.question_answers.where(correct: true).count.to_f / @exam_answer.question_answers.count.to_f

          if @exam_answer.mark == 0
            @exam_answer.mark = 1
          end

          @exam_answer.save

          @marks = @exam_answer.user.exam_answers.joins(exam: :section).where(section: {course_id: @exam_answer.exam.section.course_id}, active: true, finished: true).where.not(mark: 0)

          if @marks.count == @exam_answer.exam.section.course.sections.joins(:exams).count
            @inscription = Inscription.where(course_id: @exam_answer.exam.section.course_id, user_id: @exam_answer.user.id).first
            @inscription.mark = @marks.sum{|a| a.mark} / @marks.count
            @inscription.save
          end
        end

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
