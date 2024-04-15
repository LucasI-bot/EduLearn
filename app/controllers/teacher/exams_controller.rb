module Teacher
  class Teacher::ExamsController < Teacher::TeacherController
    def index
      @exam_answers = ExamAnswer.joins(exam: { section: { course: :user }}).where(users: { id: current_user.id })
    end

    def show
      @exam = Exam.find(params[:id])
    end

    def new
      @exam = Exam.new()
      @section = Section.find_by_id(params[:section_id])
    end

    def create
      @section = Section.find_by_id(params[:section_id])
      @exam = @section.exams.new(exam_params)

      if @exam.save
        redirect_to teacher_course_section_exam_path(@section.course, @section, @exam)
      else
        render 'new'
      end
    end

    def edit
      @exam = Exam.find_by(id: params[:id])
      @section = Section.find_by_id(params[:section_id])
    end

    def update
      @exam = Exam.find_by(id: params[:id])

      if @exam.update(exam_params)
        redirect_to teacher_course_path(@exam.section.course)
      else
        render 'new'
      end
    end

    def destroy
      @exam = Exam.find(params[:id])
      @course = Course.find(params[:course_id])
      @exam.destroy

      redirect_to teacher_course_path(@course)
    end

    private
      def exam_params
        params.require(:exam).permit(:title)
      end
  end
end
