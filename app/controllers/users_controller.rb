class UsersController < ApplicationController
    def show
        @teacher = User.find_by(id: params[:id])
    end

    def new
        @user = User.new
    end

    def edit
    end

    def update
        if current_user.update(user_params)
            current_user.inscriptions.each(&:order_value)
            redirect_to profile_path
        else
            flash.now[:alert] = current_user.errors
            render :edit
        end
      end

    def create
        @user = User.new(user_params)

        if @user.role == 'teacher'
            @user.rating = 0
        end

        unless @user.alias.present?
            @user.alias = nil
        end

        if @user.save
        # stores saved user id in a session
            login @user
            if @user.role == 'student'
                Course.where(visibility: true).each do |course|
                    @inscription = Inscription.new()

                    @inscription.user_id = @user.id
                    @inscription.course_id = course.id
                    @inscription.mark = 0
                    @inscription.approved = false
                    @inscription.paid = false

                    @inscription.save

                    @inscription.order_value
                end

                redirect_to courses_path
            else
                redirect_to teacher_root_path
            end
        else
            flash.now[:notice] = @user.errors
            render :new
        end
    end

    protected

    def user_params
        # strong parameters
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :last_name, :first_name, :alias, :birth_date, :role, :picture, skill_ids: [], subject_ids: [])
    end
end
