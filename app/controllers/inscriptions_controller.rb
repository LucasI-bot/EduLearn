class InscriptionsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @inscription = Inscription.where(user_id: current_user.id, course_id: @course.id).first

    @inscription.paid = true
    @inscription.approved = !@course.acceptance_required
    @inscription.inscription_date = Date.today

    if @inscription.save
      @payment = @inscription.payments.new()

      @payment.price = @inscription.course.price

      @payment.save

      flash[:success] = "¡Inscripción exitosa!"
      redirect_to course_path(@course)
    else
      flash[:error] = "Inscripción fallida"
      redirect_to course_path(@course)
    end
  end
end
