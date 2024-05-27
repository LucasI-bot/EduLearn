module Student
  class Student::CoursesController < Student::StudentController
    def index
      @courses = current_user.inscriptions.where(paid: true, approved: true).map{|a| a.course}
    end

    def update
      @inscription = Inscription.where(user_id: current_user.id, course_id: params[:id]).first
      @course = Course.find(params[:id])
      @teacher = @course.user

      if @inscription.update(inscription_params)
        course_ratings = @course.inscriptions.where.not(rating: nil).map{|a| a.rating}
        teacher_ratings = @teacher.courses.where.not(rating: 0).map{|a| a.rating}

        @course.rating = course_ratings.sum / course_ratings.size.to_f
        @course.save

        @teacher.rating = teacher_ratings.sum / teacher_ratings.size.to_f
        @teacher.save

        redirect_to student_course_path(@course)
      else
        render 'edit'
      end
    end

    def show
      @course = Course.find(params[:id])
      @inscription = Inscription.where(user_id: current_user.id, course_id: params[:id]).first
    end

    def destroy
      @inscription = Inscription.where(course_id: params[:id], user_id: current_user.id).first

      @inscription.paid = false
      @inscription.approved = false

      @inscription.save

      redirect_to student_root_path
    end

    private
      def inscription_params
        params.require(:inscription).permit(:rating, :review)
      end
  end
end
