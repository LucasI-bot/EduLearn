module Student
  class Student::LecturesController < Student::StudentController
    def show
      @lecture = Lecture.find(params[:id])
    end
  end
end
