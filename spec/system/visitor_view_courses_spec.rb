require 'rails_helper'

describe 'Visitor view courses' do
  it 'successfully' do
    course1 = Course.create!(name: 'Ruby', 
                             description: 'Um curso de Ruby',
                             code: 'RUBYBASIC', 
                             price: 10,
                             enrollment_deadline: '22/12/2033')
    course2 = Course.create!(name: 'Ruby on Rails',
                             description: 'Um curso de Ruby on Rails',
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
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS', 
                            price: 20,
                            enrollment_deadline: '20/12/2033')

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_content(course.name)
    expect(page).to have_content(course.description)
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
    Course.create!(name: 'Ruby', 
                   description: 'Um curso de Ruby',
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