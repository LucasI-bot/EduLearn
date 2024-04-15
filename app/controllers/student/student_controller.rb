module Student
  class StudentController < ApplicationController
    before_action :validate_user

    def validate_user
      if current_user
        unless current_user.role == "student"
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    end
  end
end
