module Teacher
  class Teacher::ConversationsController < Teacher::TeacherController
    def index
      if params[:course_id]
        @course = Course.find(params[:course_id])
        @conversations = Conversation.joins(student: :inscriptions).where(inscriptions: {course_id: @course.id})
      else
        @conversations = Conversation.where(teacher_id: current_user.id)
      end

      case params[:order_by]
      when 'student'
        @conversations = @conversations.joins(:student).order(Arel.sql("COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)) " + params[:order]))
      when 'courses'
        @conversations = @conversations.joins(student: { inscriptions: :course }).where(course: {user_id: current_user.id}).order(title: params[:order]).uniq
      when 'updated_at'
        @conversations = @conversations.order(updated_at: params[:order])
      else
        @conversations = @conversations.order(updated_at: :desc)
      end
    end

    def update
      @conversation = Conversation.find(params[:id])

      if message_params[:message].blank?
        @message = Message.new
        render "show"
        return
      end

      @message = @conversation.messages.new(message_params)
      @message.user_id = current_user.id

      if @message.save
        if params[:course_id]
          @course = Course.find(params[:course_id])
          redirect_to teacher_course_conversation_path(@course, @conversation)
        else
          redirect_to teacher_conversation_path(@conversation)
        end

      else
        render "show"
      end
    end

    def show
      @conversation = Conversation.find(params[:id])
      @message = Message.new

      if params[:course_id]
        @course = Course.find(params[:course_id])
      end
    end

    private
      def message_params
        params.require(:message).permit(:message)
      end
  end
end
