module Teacher
  class Teacher::LecturesController < Teacher::TeacherController
    def show
      @lecture = Lecture.find(params[:id])
      print Lecture.where(section_id: @lecture.section.course.sections.map{|a| a.id}).count
    end

    def new
      @lecture = Lecture.new()
      @section = Section.find_by_id(params[:section_id])
    end

    def create
      @section = Section.find_by_id(params[:section_id])
      @lecture = @section.lectures.new(lecture_params)

      if @lecture.save
        if @section.course.visibility
          if Lecture.where(section_id: @section.course.sections.map{|a| a.id}).count == 10
            @section.course.inscriptions.each do |inscription|
              inscription.order += 0.2
              inscription.save
            end
          end
        end

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

      if @course.visibility
        if Lecture.where(section_id: @course.sections.map{|a| a.id}).count == 9
          @course.inscriptions.each do |inscription|
            inscription.order -= 0.2
            inscription.save
          end
        end
      end

      redirect_to teacher_course_path(@course)
    end

    private
      def lecture_params
        params.require(:lecture).permit(:title)
      end
  end
end
