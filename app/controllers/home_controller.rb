class HomeController < ApplicationController
  def index
    @available_courses = Course.available #where(enrollment_deadline: Date.today..)
  end
end