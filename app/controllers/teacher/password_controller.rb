module Teacher
  class Teacher::PasswordController < Teacher::TeacherController
    add_flash_types :password, :password_confirmation
    def edit

    end

    def update
      if current_user.authenticate(params[:user][:current_password])
        if current_user.update(user_params)
          redirect_to teacher_profile_path, notice: "Contraseña cambiada correctamente"
        else
          flash.now[:password_confirmation] = "Contraseñas no coinciden"
          render :edit
        end

      else
        flash.now[:password] = "Error de autenticación"
        render :edit
      end
    end

    private
      def user_params
        params.require(:user).permit(:password, :password_confirmation)
      end
  end
end
