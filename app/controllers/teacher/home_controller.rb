module Teacher
  class Teacher::HomeController < Teacher::TeacherController
    def index
      if params[:from_date].present?
        @from_date = params[:from_date].to_date
      else
        @from_date = Date.today - 1.months
      end
      if params[:end_date].present?
        @end_date = params[:end_date].to_date
      else
        @end_date = Date.today
      end

      @courses = current_user.courses.where(id: Payment.where(created_at: @from_date.beginning_of_day..@end_date.end_of_day).map{|a| a.inscription.course_id})

      if params[:order_by].present?
        case params[:order_by]
        when 'title'
          @courses = @courses.order(title: params[:order])
        when 'price'
          @courses = @courses.order(price: params[:order])
        when 'inscriptions'
          @courses = @courses.joins(inscriptions: :payments).where(payments: { created_at: @from_date.beginning_of_day..@end_date.end_of_day }).select('courses.*, COUNT(payments.id) AS payments_count').group('courses.id').order('payments_count ' + params[:order])
        when 'earnings'
          @courses = @courses.joins(inscriptions: :payments).where(payments: { created_at: @from_date.beginning_of_day..@end_date.end_of_day }).select('courses.*, SUM(payments.price) AS payments_prices').group('courses.id').order('payments_prices ' + params[:order])
        end
      end
    end
  end
end
