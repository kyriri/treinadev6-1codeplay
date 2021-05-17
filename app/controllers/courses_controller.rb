class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      flash[:alert] = @course.errors.full_messages.join(" - ")
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course
    else
      flash[:alert] = @course.errors.full_messages.join(" - ") # TODO can we make create and update actions DRYer?
      render :new
    end
  end

  def destroy
    if @course = Course.destroy(params[:id])
      redirect_to courses_path
    else
      flash[:alert] = "Não foi possível apagar o curso" 
      render :new
    end
  end

  private

  def course_params # FIXME what's the effect of adding #require ?
    params[:course].permit(:name, 
      :description,
      :code,
      :price,
      :enrollment_deadline,
      )
  end
end