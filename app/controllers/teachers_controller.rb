class TeachersController < ApplicationController
  def index
    @teachers = User.joins(:courses).where(role: 1, courses: { visibility: true })

    case params[:order_by]
    when '1'
      @teachers = @teachers.order(Arel.sql("COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)) asc")).group('users.id')
    when '2'
      @teachers = @teachers.select("users.*, COUNT(courses.id) AS creations").order("creations desc").group('users.id')
    when '3'
      @teachers = @teachers.select("users.*, MAX(courses.updated_at) AS update").order("update desc").group('users.id')
    else
      @teachers = @teachers.order(rating: :desc).distinct
    end

    if params[:name].present?
      @teachers = @teachers.by_name(params[:name].downcase)
    end

    if params[:subject_ids].present?
      if params[:subject_ids].count > 1
        @teachers = @teachers.by_subject_ids(params[:subject_ids].drop(1))
      end
    end

    if params[:skill_ids].present?
      if params[:skill_ids].count > 1
        @teachers = @teachers.by_skill_ids(params[:skill_ids].drop(1))
      end
    end
  end

  def show
    @teacher = User.find_by(id: params[:id])
  end
end
