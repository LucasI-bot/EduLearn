class CoursesController < ApplicationController
  def index
    @courses = Course.joins(:inscriptions).where(visibility: true, inscriptions: {user_id: current_user.id}).order(order: :desc)
  end

  def show
    @course = Course.find_by(id: params[:id])
  end
end
