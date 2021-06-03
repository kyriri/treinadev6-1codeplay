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
    if @course.empty?
      # render json: '', status: 404
      head 404
    else
      render json: @course.as_json(
        except: [:id, :created_at, :updated_at, :instructor_id],
        include: { instructor: { except: :id } }
      )
    end
    
    # @course = Course.find_by!(code: params[:code]) #notice the bang
    # render json: @course
    # rescue ActiveRecord::RecordNotFound
    #   head 404
  end
end