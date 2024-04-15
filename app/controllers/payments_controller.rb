class PaymentsController < ApplicationController
  def new
    require 'paypal-sdk-rest'
    @course = Course.find(params[:course_id])
    @payment = PayPal::SDK::REST::Payment.new({
      intent: 'sale',
      payer: {
        payment_method: 'paypal'
      },
      transactions: [{
        amount: {
          total: @course.price,
          currency: 'USD'
        }
      }],
      redirect_urls: {
        return_url: 'http://localhost:3000' + course_payments_success_path(@course),
        cancel_url: 'http://localhost:3000' + course_path(@course)
      }
    })

    if @payment.create
      redirect_to @payment.links.find { |link| link.method == 'REDIRECT' }.href, allow_other_host: true
    else
      flash[:error] = @payment.error.inspect
      redirect_to course_path(@course)
    end
  end

  def success
    @course = Course.find(params[:course_id])
    if params[:paymentId] && params[:PayerID]
      # Payment was successful, process it further
      @payment_id = params[:paymentId]
      @payer_id = params[:PayerID]

      @inscription = Inscription.new()

      @inscription.user_id = current_user.id
      @inscription.course_id = @course.id
      @inscription.paid = true
      @inscription.approved = !@course.acceptance_required
      @inscription.incription_date = Date.today

      if @inscription.save
        payment = PayPal::SDK::REST::Payment.find(@payment_id)
        payment.execute(payer_id: @payer_id)

        flash[:success] = "Payment successful!"
        redirect_to root_path
      else
        flash[:error] = "Inscripción fallida"
        redirect_to course_path(@course)
      end

    else
      # Payment was not successful
      flash[:error] = "Payment failed or was canceled"
      redirect_to course_path(@course)
    end
  end
end
