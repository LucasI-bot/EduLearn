module Teacher
  class Teacher::ReviewController < Teacher::TeacherController
    def index
      @mycourses = "active"
      
      @course = Course.find(params[:course_id])
      @reviews = true
    end
  end
end
