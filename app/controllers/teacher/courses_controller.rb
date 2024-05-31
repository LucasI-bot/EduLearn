module Teacher
  class Teacher::CoursesController < Teacher::TeacherController
    def index
      if params[:order_by].present?
        if params[:order_by] == "inscriptions"
          @courses = Course.select('courses.*, COUNT(inscriptions.id) AS inscription_count')
          .joins("LEFT JOIN (SELECT * FROM inscriptions WHERE paid = true AND approved = true) AS inscriptions ON courses.id = inscriptions.course_id")
          .group('courses.id')
          .order('inscription_count ' + params[:order])
        else
          @courses = current_user.courses.order(params[:order_by] + " " + params[:order])
        end
      else
        @courses = current_user.courses
      end

      if params[:title].present?
        @courses = @courses.by_title(params[:title].downcase)
      end

      if params[:subject_ids].present?
        if params[:subject_ids].count > 1
          @courses = @courses.by_subject_ids(params[:subject_ids].drop(1))
        end
      end

      if params[:skill_ids].present?
        if params[:skill_ids].count > 1
          @courses = @courses.by_skill_ids(params[:skill_ids].drop(1))
        end
      end
    end

    def show
      @course = Course.find_by(id: params[:id])
    end

    def new
      @course = Course.new()
    end

    def create
      @course = Course.new(course_params)
      @course.user_id = current_user.id
      @course.visibility = false
      @course.rating = 0

      unless @course.price.present?
        @course.price = 0
      end

      if @course.save
        redirect_to teacher_course_path(@course)
      else
        render 'new'
      end
    end

    def edit
      @course = Course.find_by(id: params[:id])
    end

    def update
      @course = Course.find(params[:id])

      if @course.update(course_params)
        unless @course.price.present?
          @course.price = 0
          @course.save
        end

        if @course.visibility
          User.where(role: 'student').each do |student|
            @inscription = Inscription.where(user_id: student.id, course_id: @course.id).first

            if @inscription.present?
              @inscription.order_value
            else
              @inscription = Inscription.new()

              @inscription.user_id = student.id
              @inscription.course_id = @course.id
              @inscription.approved = false
              @inscription.paid = false
              @inscription.mark = 0

              @inscription.save

              @inscription.order_value
            end
          end
        end

        redirect_to teacher_courses_path
      else
        render 'edit'
      end
    end

    def destroy
      @course = Course.find(params[:id])
      @course.destroy

      redirect_to teacher_courses_path()
    end

    def order_sections
      print(params[:sections])

      params[:sections].each_with_index do |id,index|
        Section.where(id: id).update_all(position: index + 1)
      end

      head :ok
    end

    def order_lectures
      print(params[:data])

      params[:data].each do |data|
        Lecture.where(id: data[1][:lecture_id].to_i).update_all(section_id: data[1][:section_id].to_i, position: data[0].to_i + 1)
      end

      head :ok
    end

    def order_exams
      print(params[:data])

      params[:data].each do |data|
        Exam.where(id: data[1][:exam_id].to_i).update_all(section_id: data[1][:section_id].to_i, position: data[0].to_i + 1)
      end

      head :ok
    end

    def publish
      @course = Course.find(params[:id])

      if @course.visibility
        @course.update(visibility: false)
      else
        @course.update(visibility: true)

        User.where(role: 'student').each do |student|
          @inscription = Inscription.where(user_id: student.id, course_id: @course.id).first

          if @inscription.present?
            @inscription.order_value
          else
            @inscription = Inscription.new()

            @inscription.user_id = student.id
            @inscription.course_id = @course.id
            @inscription.approved = false
            @inscription.paid = false
            @inscription.mark = 0

            @inscription.save

            @inscription.order_value
          end
        end
      end

      redirect_to teacher_courses_path
    end

    private
      def course_params
        params.require(:course).permit(:title, :description, :detailed_description, :price, :start_date, :end_date, :inscription_start_date, :inscription_end_date, :visibility, :acceptance_required, :banner_img, skill_ids: [], subject_ids: [])
      end
  end
end
