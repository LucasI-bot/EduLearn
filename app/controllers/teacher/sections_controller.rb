module Teacher
  class Teacher::SectionsController < Teacher::TeacherController
    def new
      @section = Section.new()
      @course = Course.find_by_id(params[:course_id])
    end

    def create
      @course = Course.find_by_id(params[:course_id])
      @section = @course.sections.new(section_params)

      if @section.save
        redirect_to teacher_course_path(@course)
      else
        render 'new'
      end
    end

    def edit
      @section = Section.find_by(id: params[:id])
    end

    def update
      @section = Section.find_by(id: params[:id])

      if @section.update(section_params)
        redirect_to teacher_course_path(@section.course)
      else
        render 'new'
      end
    end

    def destroy
    end

    private
      def section_params
        params.require(:section).permit(:title)
      end
  end
end
