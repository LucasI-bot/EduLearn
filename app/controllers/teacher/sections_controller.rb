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
        if @course.visibility
          if @course.sections.count == 4
            @course.inscriptions.each do |inscription|
              inscription.order += 0.2
              inscription.save
            end
          end
        end

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
      @section = Section.find(params[:id])
      @course = Course.find(params[:course_id])

      if @course.visibility
        if (Lecture.where(section_id: @course.sections.map{|a| a.id}).count > 9) && ((Lecture.where(section_id: @course.sections.map{|a| a.id}).count - @section.lectures.count) < 10)
          @lectures = true
        else
          @lectures = false
        end
        if (Exam.where(section_id: @course.sections.map{|a| a.id}).count > 5) && ((Exam.where(section_id: @course.sections.map{|a| a.id}).count - @section.lectures.count) < 6)
          @exams = true
        else
          @exams = false
        end
      end

      @section.destroy

      if @course.visibility
        if @course.sections.count == 3
          @course.inscriptions.each do |inscription|
            inscription.order -= 0.2
            inscription.save
          end
        end
        if @lectures
          @course.inscriptions.each do |inscription|
            inscription.order -= 0.2
            inscription.save
          end
        end
        if @exams
          @course.inscriptions.each do |inscription|
            inscription.order -= 0.2
            inscription.save
          end
        end
      end

      redirect_to teacher_course_path(@course)
    end

    private
      def section_params
        params.require(:section).permit(:title)
      end
  end
end
