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

      current_user.inscriptions.each(&:order_value)

      flash[:success] = "¡Inscripción exitosa!"
      if @inscription.approved
        redirect_to student_course_path(@course)
      else
        redirect_to course_path(@course)
      end
    else
      flash[:error] = "Inscripción fallida"
      redirect_to course_path(@course)
    end
  end
end
