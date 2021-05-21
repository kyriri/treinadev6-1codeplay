class ForbidNullOnInstructorId < ActiveRecord::Migration[6.1]
  def change
    Course.update_all(instructor_id: 1)
    change_column_null :courses, :instructor_id, false
  end
end
