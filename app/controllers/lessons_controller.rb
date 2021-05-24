class LessonsController < ApplicationController

  def create
    @course = Course.find(params[:course_id])
    # @lesson = @course.lesson.create!(lesson_params)
    @lesson = Lesson.new(lesson_params)
    @lesson.course = @course
    @lesson.save!
    redirect_to course_path(@course)
  end

  private

  def lesson_params 
    params[:lesson].permit(:name, 
                           :number,
                          )
  end
end