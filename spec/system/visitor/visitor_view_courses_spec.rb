require 'rails_helper'

describe 'Visitor view courses' do
  it 'successfully' do
    teacher = Instructor.create!(name: 'Nadya Ferris',
                                    bio: 'Self-taught Ruby on Rails teacher',
                                    email: 'ferrisn@coldmail.com')
    
    course1 = Course.create!(name: 'Ruby', 
                             description: 'Um curso de Ruby',
                             instructor: teacher, 
                             code: 'RUBYBASIC', 
                             price: 10,
                             enrollment_deadline: '22/12/2033')
    course2 = Course.create!(name: 'Ruby on Rails',
                             description: 'Um curso de Ruby on Rails',
                             instructor: teacher, 
                             code: 'RUBYONRAILS', 
                             price: 20,
                             enrollment_deadline: '20/12/2033')

    visit root_path
    click_on 'Cursos'

    expect(page).to have_content(course1.name)
    expect(page).to have_content(course2.description)
    expect(page).to have_content('R$ 20,00')
  end

  it 'and view details' do
    teacher = Instructor.create!(name: 'Nadya Ferris',
                                 bio: 'Self-taught Ruby on Rails teacher',
                                 email: 'ferrisn@coldmail.com')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            instructor: teacher, 
                            code: 'RUBYONRAILS', 
                            price: 20,
                            enrollment_deadline: '20/12/2033')

    visit root_path
    click_on 'Cursos'
    click_on course.name

    expect(page).to have_content(course.name)
    expect(page).to have_content(course.description)
    # expect(page).to have_content(course.instructor.name)
    expect(page).to have_content(course.code)
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')
  end

  it 'and no course is available' do
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Nenhum curso disponível')
  end

  it 'and return to home page' do
    visit root_path
    click_on 'Cursos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    teacher = Instructor.create!(name: 'Nadya Ferris',
                                 bio: 'Self-taught Ruby on Rails teacher',
                                 email: 'ferrisn@coldmail.com')
    Course.create!(name: 'Ruby', 
                   description: 'Um curso de Ruby',
                   instructor: teacher, 
                   code: 'RUBYBASIC', 
                   price: 10,
                   enrollment_deadline: '22/12/2033')

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Voltar'

    expect(current_path).to eq courses_path
  end
end