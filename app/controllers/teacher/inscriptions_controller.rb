module Teacher
  class Teacher::InscriptionsController < Teacher::TeacherController
    def index
      if params[:course_id]
        @course = Course.find(params[:course_id])
        @inscriptions = Inscription.joins(:course).where(paid: true, approved: false, courses: {id: @course.id})
      else
        @myinscriptions = "active"
        
        @inscriptions = Inscription.joins(:course).where(paid: true, approved: false, courses: {user_id: current_user.id})
      end

      if params[:name].present?
        @inscriptions = @inscriptions.by_name(params[:name].downcase)
      end

      if params[:course].present?
        @inscriptions = @inscriptions.by_course_id(params[:course].downcase)
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

      @inscription.paid = false

      if @inscription.approved
        @inscription.approved = false
        @inscription.save

        @inscription.user.inscriptions.each(&:order_value)

        if params[:course_id]
          @course = Course.find(params[:course_id])
          redirect_to teacher_course_students_path(@course)
        else
          redirect_to teacher_students_path
        end
      else
        @inscription.save

        @inscription.user.inscriptions.each(&:order_value)

        if params[:course_id]
          @course = Course.find(params[:course_id])
          redirect_to teacher_course_inscriptions_path(@course)
        else
          redirect_to teacher_inscriptions_path
        end
      end
    end

    def update
      @inscription = Inscription.find(params[:id])

      @inscription.approved = true

      @inscription.save

      if params[:course_id]
        @course = Course.find(params[:course_id])
        redirect_to teacher_course_inscriptions_path(@course)
      else
        redirect_to teacher_inscriptions_path
      end
    end
  end
end
