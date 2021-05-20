class AddInstructorToCourses < ActiveRecord::Migration[6.1]
  def change
    change_table :instructors do |t|
      t.belongs_to :course
    end
  end
end
