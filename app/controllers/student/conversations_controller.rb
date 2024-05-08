module Student
  class Student::ConversationsController < Student::StudentController
    def index
      @conversations = Conversation.where(student_id: current_user.id)

      case params[:order_by]
      when 'teacher'
        @conversations = @conversations.joins(:teacher).order(Arel.sql("COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)) " + params[:order]))
      when 'courses'
        @conversations = @conversations.joins(teacher: { courses: :inscriptions }).where(inscriptions: {approved: true, paid: true, user_id: current_user.id}).order(title: params[:order]).uniq
      when 'updated_at'
        @conversations = @conversations.order(updated_at: params[:order])
      else
        @conversations = @conversations.order(updated_at: :desc)
      end
    end

    def create
      @conversation = Conversation.where(student_id: current_user.id, teacher_id: params[:teacher_id]).first

      if @conversation
        redirect_to student_conversation_path(@conversation)
      else
        @conversation = Conversation.create({student_id: current_user.id, teacher_id: params[:teacher_id]})

        redirect_to student_conversation_path(@conversation)
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
        redirect_to student_conversation_path(@conversation)
      else
        render "show"
      end
    end

    def show
      @conversation = Conversation.find(params[:id])
      @message = Message.new

      unless @conversation.student == current_user
        redirect_to student_conversations_path
      end
    end

    private
      def message_params
        params.require(:message).permit(:message)
      end
  end
end
