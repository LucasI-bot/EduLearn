module Teacher
  class Teacher::UsersController < Teacher::TeacherController
    def show

    end

    def edit

    end

    def update
      if current_user.update(user_params)
        redirect_to teacher_profile_path
      else
        render :edit
      end
    end

    private
      def user_params
        params.require(:user).permit(:picture, :email, :first_name, :last_name, :alias)
      end
  end
end
