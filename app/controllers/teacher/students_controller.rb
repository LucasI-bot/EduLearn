module Teacher
  class Teacher::StudentsController < Teacher::TeacherController
    def index
      if params[:course_id]
        @course = Course.find(params[:course_id])
        @students = User.joins(:inscriptions).where(inscriptions: { paid: true, approved: true, course_id: @course.id }).group('users.id')
      else
        @students = User.joins(:inscriptions).where(inscriptions: { paid: true, approved: true, course_id: current_user.courses.map{|a| a.id} }).group('users.id')
      end

      case params[:order_by]
      when 'name'
        @students = @students.order(Arel.sql("COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)) " + params[:order]))
      when 'mark'
        @marks = @students.where.not(inscriptions: { mark: nil }).select('users.*, AVG(inscriptions.mark) AS mean_mark').order('mean_mark ' + params[:order])
        @no_marks = @students.where(inscriptions: { mark: nil }).where.not(id: @marks.map{|a| a.id})
        if params[:order] == 'asc'
          @students = @no_marks + @marks
        else
          @students = @marks + @no_marks
        end
      when 'first_inscription'
        @students = @students.select('users.*, MIN(inscriptions.inscription_date) AS first_inscription').order('first_inscription ' + params[:order])
      when 'last_inscription'
        @students = @students.select('users.*, MAX(inscriptions.inscription_date) AS last_inscription').order('last_inscription ' + params[:order])
      when 'inscription'
        @students = @students.select('users.*, MAX(inscriptions.inscription_date) AS inscription').order('inscription ' + params[:order])
      when 'inscriptions'
        @students = @students.select('users.*, COUNT(inscriptions.id) AS count').order('count ' + params[:order])
      end
    end

    def show

    end
  end
end
