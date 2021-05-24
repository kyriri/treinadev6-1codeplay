class CoursesController < ApplicationController
before_action :find_course, only: %i[show edit update destroy] 

  def index
    @courses = Course.all
  end

  def show
    @lessons = Lesson.where("course_id = #{params[:id]}")
  end

  def new
    @course = Course.new
    @instructors = Instructor.all
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      flash[:alert] = @course.errors.full_messages.join(" - ")
      @instructors = Instructor.all
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to @course
    else
      flash[:alert] = @course.errors.full_messages.join(" - ") # TODO can we make create and update actions DRYer?
      render :edit # FIXME flash doesn't go well with render -> flash.now better
    end
  end

  def destroy
    if @course.destroy
      redirect_to courses_path
    else
      flash[:alert] = "Não foi possível apagar o curso" 
      redirect_to @course
    end
  end

  private

  def find_course
    @course = Course.find(params[:id])
  end

  def course_params 
    params[:course].permit(:name, 
                           :description,
                           :instructor_id,
                           :code,
                           :price,
                           :enrollment_deadline,
                          )
  end
end