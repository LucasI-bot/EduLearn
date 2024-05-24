module Teacher
  class Teacher::ReviewController < Teacher::TeacherController
    def index
      @course = Course.find(params[:course_id])
      @reviews = true
    end
  end
end
