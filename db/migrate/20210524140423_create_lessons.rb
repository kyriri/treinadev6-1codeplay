class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.integer    :number
      t.string     :name
      t.belongs_to :course, foreign_key: true
      t.timestamps
    end
  end
end
