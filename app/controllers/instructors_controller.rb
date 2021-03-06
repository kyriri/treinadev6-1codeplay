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

  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
    @instructor = Instructor.find(params[:id])

    if @instructor.update(instructor_params)
      redirect_to @instructor
    else
      flash[:alert] = @instructor.errors.full_messages.join(" - ") # TODO can we make create and update actions DRYer?
      render :edit
    end
  end

  def destroy
    if @instructor = Instructor.destroy(params[:id])
      redirect_to instructors_path
    else
      flash[:alert] = "Não foi possível apagar o registro" 
      redirect_to @instructor
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