class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if @user.authenticate(params[:user][:password])
        login @user

        if @user.role == 'student'
          redirect_to student_root_path
        else
            redirect_to teacher_root_path
        end
      else
        flash.now[:alert] = "Verifique su email y contraseña."
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Verifique su email y contraseña."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
