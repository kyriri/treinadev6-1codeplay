require 'rails_helper'

describe 'Admin registers lessons' do
  it 'from course page' do
    teacher = Instructor.create!(name: 'Renato Anelli',
                                 email: 'anelli@usp.com.br')
    course = Course.create!(name: 'A arquitetura de Lina Bo Bardi', 
                            instructor: teacher, 
                            code: 'ARQ101', 
                            enrollment_deadline: '05/07/2024',
                            price: 0)

    visit course_path(course)
    fill_in 'Número da aula', with: '3'
    fill_in 'Nome', with: 'Primeiros esboços'
    click_on 'Registrar aula'

    expect(page).to have_content('Primeiros esboços')
  end

  it 'and lesson number must be unique' do
    
  end
end