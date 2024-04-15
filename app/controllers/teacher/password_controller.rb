module Teacher
  class Teacher::PasswordController < Teacher::TeacherController
    def edit

    end

    def update
      if current_user.authenticate(params[:user][:current_password])
        if current_user.update(user_params)
          print("Contraseña cambiada correctamente")
          redirect_to teacher_profile_path
        else
          print("Contraseñas no coinciden")
          render :edit
        end

      else
        print("Error de autenticación")
        render :edit
      end
    end

    private
      def user_params
        params.require(:user).permit(:password, :password_confirmation)
      end
  end
end
