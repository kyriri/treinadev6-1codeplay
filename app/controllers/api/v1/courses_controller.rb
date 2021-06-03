class Api::V1::CoursesController < ActionController::API

  def index
    @courses = Course.where('enrollment_deadline >= ?', Date.current)
    # render json: @courses.to_json, status: 200
    render json: @courses.as_json(
      except: [:id, :created_at, :updated_at, :instructor_id],
      include: { instructor: { except: :id } }
     )
  end

  def show
    @course = Course.where(code: params[:code])
    render json: @course.as_json(
      except: [:id, :created_at, :updated_at, :instructor_id],
      include: { instructor: { except: :id } }
     )
  end
end