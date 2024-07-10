class CoursesController < ApplicationController
  def index
    if current_user.present?
      if current_user.role == 'student'
        @courses = Course.joins(:inscriptions).where(visibility: true, inscriptions: {user_id: current_user.id, paid: false})
      else
        @courses = Course.where(visibility: true)
      end
    else
      @courses = Course.where(visibility: true)
    end

    if params[:title].present?
      @courses = @courses.by_title(params[:title].downcase)
    end

    if params[:teacher].present?
      @courses = @courses.by_teacher(params[:teacher].downcase)
    end

    if params[:acceptance_required].present?
      @courses = @courses.by_acceptance(params[:acceptance_required])
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

    if params[:free] == "1"
      @courses = @courses.where(price: 0)
    end

    case params[:order_by]
    when '1'
      @courses = @courses.order(rating: :desc)
    when '2'
      @courses = @courses.order(price: :desc)
    when '3'
      @courses = @courses.order(created_at: :desc)
    when '4'
      @courses = @courses.order(updated_at: :desc)
    when '5'
      @courses = @courses.order(title: :asc)
    when '6'
      @courses = @courses.joins(:user).order(Arel.sql("COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)) asc"))
    else
      if current_user.present?
        if current_user.role == 'student'
          @courses = @courses.order(order: :desc)
        else
          @courses = @courses.order(rating: :desc)
        end
      else
        @courses = @courses.order(rating: :desc)
      end
    end
  end

  def show
    @course = Course.find_by(id: params[:id])
  end
end
