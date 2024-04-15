module Teacher
  class Teacher::ContentsController < Teacher::TeacherController
    def new
      @content = Content.new()
      @lecture = Lecture.find_by_id(params[:lecture_id])
      @content.content_type = params[:type]
    end

    def create
      @lecture = Lecture.find_by_id(params[:lecture_id])
      @content = @lecture.contents.new(content_params)

      if @content.save
        redirect_to teacher_course_section_lecture_path(@lecture.section.course, @lecture.section, @lecture)
      else
        render 'new'
      end
    end

    def edit
      @content = Content.find_by(id: params[:id])
      @lecture = Lecture.find(params[:lecture_id])
    end

    def update
      @lecture = Lecture.find_by_id(params[:lecture_id])
      @content = Content.find(params[:id])

      if @content.update(content_params)
        redirect_to teacher_course_section_lecture_path(@lecture.section.course, @lecture.section, @lecture)
      else
        render 'edit'
      end
    end

    def destroy
    end

    private
      def content_params
        params.require(:content).permit(:content_type, :video, :pdf, :text, :banner_img)
      end
  end
end
