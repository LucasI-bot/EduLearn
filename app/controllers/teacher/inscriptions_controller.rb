module Teacher
  class Teacher::InscriptionsController < Teacher::TeacherController
    def index
      if params[:course_id]
        @course = Course.find(params[:course_id])
        @inscriptions = Inscription.joins(:course).where(paid: true, approved: false, courses: {id: @course.id})
      else
        @inscriptions = Inscription.joins(:course).where(paid: true, approved: false, courses: {user_id: current_user.id})
      end

      case params[:order_by]
      when 'alias'
        @inscriptions = @inscriptions.joins(:user).order(Arel.sql("COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)) " + params[:order]))
      when 'course'
        @inscriptions = @inscriptions.order(title: params[:order])
      when 'created_at'
        @inscriptions = @inscriptions.order(created_at: params[:order])
      end
    end

    def destroy
      @inscription = Inscription.find(params[:id])

      @inscription.destroy

      if params[:course_id]
        @course = Course.find(params[:course_id])
        redirect_to teacher_course_inscriptions_path(@course)
      end

      redirect_to teacher_inscriptions_path
    end

    def update
      if params[:course_id]
        @course = Course.find(params[:course_id])
      end

      @inscription = Inscription.find(params[:id])

      @inscription.approved = true

      @inscription.save

      if params[:course_id]
        @course = Course.find(params[:course_id])
        redirect_to teacher_course_inscriptions_path(@course)
      end

      redirect_to teacher_inscriptions_path
    end
  end
end
