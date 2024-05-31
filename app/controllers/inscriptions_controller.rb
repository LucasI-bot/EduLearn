class InscriptionsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @inscription = Inscription.new()

    @inscription.user_id = current_user.id
    @inscription.course_id = @course.id
    @inscription.paid = true
    @inscription.mark = 0
    @inscription.approved = !@course.acceptance_required

    if @inscription.save
      flash[:success] = "Payment successful!"
      redirect_to root_path
    else
      flash[:error] = "Inscripción fallida"
      redirect_to course_path(@course)
    end
  end
end
