class HomeController < ApplicationController
  def index
    @available_courses = Course.where("enrollment_deadline >= ?", Date.today)
  end
end