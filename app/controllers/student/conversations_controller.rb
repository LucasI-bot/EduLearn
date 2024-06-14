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
      @course = Course.find(params[:course_id])

      if @conversation
        redirect_to student_course_chat_path(@course)
      else
        @conversation = Conversation.create({student_id: current_user.id, teacher_id: params[:teacher_id]})

        redirect_to student_course_chat_path(@course)
      end
    end

    def update
      if params[:course_id]
        @course = Course.find(params[:course_id])
        @conversation = Conversation.where(student_id: current_user.id, teacher_id: @course.user_id).first
      else
        @conversation = Conversation.find(params[:id])
      end

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
          redirect_to student_course_chat_path(@course)
        else
          redirect_to student_conversation_path(@conversation)
        end

      else
        render "show"
      end
    end

    def show
      if params[:id]
        @conversation = Conversation.find(params[:id])

        @conversation.messages.where.not(user_id: current_user.id).where.not(seen: true).update_all(seen: true)

        unless @conversation.student == current_user
          redirect_to student_conversations_path
        end
      else
        @course = Course.find(params[:course_id])
        @conversation = Conversation.where(student_id: current_user.id, teacher_id: @course.user_id).first
        @inscription = Inscription.where(user_id: current_user.id, course_id: params[:course_id]).first
      end
      @message = Message.new
    end

    private
      def message_params
        params.require(:message).permit(:message)
      end
  end
end
