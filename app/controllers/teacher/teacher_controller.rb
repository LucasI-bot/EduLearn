module Teacher
  class TeacherController < ApplicationController
    layout "teacher"
    before_action :validate_user

    def validate_user
      if current_user
        unless current_user.role == "teacher"
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    end
  end
end
