module Teacher
  class Teacher::QuestionAnswersController < Teacher::TeacherController
    def download
      @question_answer = QuestionAnswer.find(params[:id])
      send_file @question_answer.file.download
    end
  end
end
