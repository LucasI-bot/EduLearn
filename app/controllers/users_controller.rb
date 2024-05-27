class UsersController < ApplicationController

    def index
        @teachers = User.all.where(:role => 1)
    end

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
            render :edit
        end
      end

    def create
        @user = User.new(user_params)

        if @user.save
        # stores saved user id in a session
            login @user
            if @user.role == 'student'
                Course.where(visibility: true).each do |course|
                    @inscription = Inscription.new()

                    @inscription.user_id = @user.id
                    @inscription.course_id = course.id
                    @inscription.approved = false
                    @inscription.paid = false

                    @inscription.save

                    @inscription.order_value
                end
                
                redirect_to student_root_path, notice: 'Successfully created account'
            else
                redirect_to teacher_root_path, notice: 'Successfully created account'
            end
        else
            flash.now[:alert] = 'Alert message!'
            redirect_to signup_path, notice: "Ocurrió un error al crear el usuario, intente nuevamente"
        end
    end

    protected

    def user_params
        # strong parameters
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :last_name, :first_name, :alias, :birth_date, :role, :picture, skill_ids: [], subject_ids: [])
    end
end
