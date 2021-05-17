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

  private

  def course_params
    params[:course].permit(:name, 
      :description,
      :code,
      :price,
      :enrollment_deadline,
      )
  end
end