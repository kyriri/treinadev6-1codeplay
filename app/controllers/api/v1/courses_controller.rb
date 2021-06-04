class Api::V1::CoursesController < ActionController::API

  def index
    @courses = Course.where('enrollment_deadline >= ?', Date.current)
    # render json: @courses.to_json, status: 200
    render json: @courses.as_json(
      except: [:id, :created_at, :updated_at, :instructor_id],
        include: { instructor: { only: %i[name bio] } }
     )
  end

  def show
    @course = Course.where(code: params[:code])
    if @course.empty?
      # render json: '', status: 404
      head 404
    else
      render json: @course.as_json(
        except: %i[id created_at updated_at instructor_id],
        include: { instructor: { only: %i[name bio] } }
      )
    end
    
    # @course = Course.find_by!(code: params[:code]) #notice the bang
    # render json: @course
    # rescue ActiveRecord::RecordNotFound
    #   head 404
  end

  def create
    @new_course = Course.new(course_params)
    # @new_course.save! # the bang make sure the object was saved to the database
    @new_course.save
    if @new_course.persisted?
      render json: @new_course, status: 201 # :created
    else
      head 406
    end
  end

  def destroy
    @course = Course.find_by!(code: params[:code])
    @course.destroy
    render json: { notice: "Course deleted. " }, status: 200
  rescue ActiveRecord::RecordNotFound
      head 400
  end

  private

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