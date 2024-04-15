class TeachersController < ApplicationController
  def index
    @teachers = User.all.where(:role => 1)
  end

  def show
    @teacher = User.find_by(id: params[:id])
  end
end
