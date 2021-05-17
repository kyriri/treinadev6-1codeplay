class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.all
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      redirect_to @instructor
    else
      flash[:alert] = @instructor.errors.full_messages.join(" - ")
      render :new
    end
  end

  private

  def instructor_params
    params[:instructor].permit(:name, 
                               :bio,
                               :email,
                               :profile_picture,
                              )
  end
end