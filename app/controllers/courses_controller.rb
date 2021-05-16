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
    @course = Course.new(params[:course].permit(:name, 
                                       :description,
                                       :code,
                                       :price,
                                       :enrollment_deadline,
                                       ))
    @course.save
    redirect_to @course
  end
end