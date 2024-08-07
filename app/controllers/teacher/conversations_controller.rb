module Teacher
  class Teacher::ConversationsController < Teacher::TeacherController
    def index
      if params[:course_id]
        @mycourses = "active"

        @course = Course.find(params[:course_id])
        @conversations = Conversation.joins(student: :inscriptions).where(inscriptions: {course_id: @course.id}, teacher_id: current_user.id)
      else
        @myconversations = "active"

        @conversations = Conversation.where(teacher_id: current_user.id)
      end

      if params[:name].present?
        @conversations = @conversations.by_name(params[:name].downcase)
      end

      if params[:course].present?
        @conversations = @conversations.by_course_id(params[:course].downcase)
      end

      case params[:order_by]
      when 'student'
        @conversations = @conversations.joins(:student).order(Arel.sql("COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)) " + params[:order]))
      when 'courses'
        @conversations = @conversations.joins(student: { inscriptions: :course }).where(inscriptions: {paid: true, approved: true}, course: {user_id: current_user.id}).order(title: params[:order]).uniq
      when 'updated_at'
        @conversations = @conversations.joins(:messages).select('conversations.*, MAX(messages.created_at) AS update').group('conversations.id').order("update  " + params[:order])
      else
        @conversations = @conversations.joins(:messages).select('conversations.*, MAX(messages.created_at) AS update').group('conversations.id').order("update  desc")
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
      @message.seen = false

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

      @conversation.messages.where.not(user_id: current_user.id).where.not(seen: true).update_all(seen: true)

      if params[:course_id]
        @mycourses = "active"

        @course = Course.find(params[:course_id])
      else
        @myconversations = "active"
      end

      unless @conversation.teacher == current_user
        redirect_to student_conversations_path
      end
    end

    private
      def message_params
        params.require(:message).permit(:message)
      end
  end
end
