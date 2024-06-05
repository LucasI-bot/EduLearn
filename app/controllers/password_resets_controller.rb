class PasswordResetsController < ApplicationController

  def new

  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')

    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to '/login', alert: 'Tu link ha expirado, intente nuevamente'
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    if @user.update(password_params)
      redirect_to '/login', notice: 'Su contraseña se ha cambiado con éxito, puede iniciar sesión'
    else
      flash.now[:alert] = "Verifique las contraseñas ingresadas"
      render 'edit'
    end
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to '/login', alert: 'Tu link ha expirado, intente nuevamente'
  end

  def create
    if @user = User.find_by_email(params[:email])
      PasswordMailer.with(user: @user).reset.deliver_now
    end

    redirect_to '/login', notice: 'Si se encontró a una cuenta con el email ingresado, se le ha enviado un correo para reiniciar la contraseña'
  end

  private
      def password_params
        params.require(:user).permit(:password, :password_confirmation)
      end
end
