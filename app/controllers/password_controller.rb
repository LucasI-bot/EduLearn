class PasswordController < ApplicationController
  add_flash_types :password, :password_confirmation
  def edit
  end

  def update
    if current_user.authenticate(params[:user][:current_password])
      if current_user.update(user_params)
        redirect_to profile_path, notice: "Contraseña cambiada correctamente"
      else
        flash.now[:password_confirmation] = "Contraseñas no coinciden"
        render :edit
      end

    else
      flash.now[:password] = "Error de autenticación"
      render :edit
    end
  end

  protected

  def user_params
      # strong parameters
      params.require(:user).permit(:password, :password_confirmation)
  end
end
