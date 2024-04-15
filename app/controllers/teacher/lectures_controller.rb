module Teacher
  class Teacher::LecturesController < Teacher::TeacherController
    def show
      @lecture = Lecture.find(params[:id])
    end

    def new
      @lecture = Lecture.new()
      @section = Section.find_by_id(params[:section_id])
    end

    def create
      @section = Section.find_by_id(params[:section_id])
      @lecture = @section.lectures.new(lecture_params)

      if @lecture.save
        redirect_to teacher_course_section_lecture_path(@section.course, @section, @lecture)
      else
        render 'new'
      end
    end

    def edit
      @lecture = Lecture.find_by(id: params[:id])
      @section = Section.find_by_id(params[:section_id])
    end

    def update
      @lecture = Lecture.find_by(id: params[:id])

      if @lecture.update(lecture_params)
        redirect_to teacher_course_path(@lecture.section.course)
      else
        render 'new'
      end
    end

    def destroy
      @lecture = Lecture.find(params[:id])
      @course = Course.find(params[:course_id])
      @lecture.destroy

      redirect_to teacher_course_path(@course)
    end

    private
      def lecture_params
        params.require(:lecture).permit(:title)
      end
  end
end
