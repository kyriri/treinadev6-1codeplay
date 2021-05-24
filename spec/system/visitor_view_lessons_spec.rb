require 'rails_helper'

describe 'Visitor accesses list of lessons' do
  it 'successfully' do
    teacher = Instructor.create!(name: 'Renato Anelli',
                                 email: 'anelli@usp.com.br')
    course = Course.create!(name: 'A arquitetura de Lina Bo Bardi', 
                            instructor: teacher, 
                            code: 'ARQ101', 
                            enrollment_deadline: '05/07/2024',
                            price: 0)
    lesson1 = Lesson.create!(number: 1,
                             name: 'Introdução',
                             course: course)
    lesson2 = Lesson.create!(number: 2,
                             name: 'A formação do acervo do MASP',
                             course: course)

    visit root_path
    click_on 'Cursos'
    click_on 'A arquitetura de Lina Bo Bardi'

    expect(page).to have_content('Introdução')
    expect(page).to have_content('A formação do acervo do MASP')
  end

  it 'but there\'s none' do
    teacher = Instructor.create!(name: 'Renato Anelli',
                                 email: 'anelli@usp.com.br')
    Course.create!(name: 'A arquitetura de Lina Bo Bardi', 
                  instructor: teacher, 
                  code: 'ARQ101', 
                  enrollment_deadline: '05/07/2024',
                  price: 0)

    visit courses_path
    click_on 'A arquitetura de Lina Bo Bardi'

    expect(page).to have_content('Nenhum aula cadastrada')
  end
  
end