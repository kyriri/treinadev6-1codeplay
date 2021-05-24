require 'rails_helper'

describe Lesson do
  it 'is correctly associated to a Course' do
    teacher = Instructor.create!(name: 'Nadya Ferris',
                                 email: 'ferrisn@coldmail.com')
    course = Course.create!(name: 'Ruby', 
                            instructor: teacher, 
                            code: 'RUBYBASIC', 
                            price: 10)
    lesson = Lesson.create!(number: 1,
                            name: 'Welcome to Ruby development!',
                            course: course)

    expect(lesson.course.name).to eq('Ruby')
    expect(lesson.course.instructor.name).to eq('Nadya Ferris')
  end
end
