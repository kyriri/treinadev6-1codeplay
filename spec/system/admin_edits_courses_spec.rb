require 'rails_helper'

describe 'Admin updates course' do
  it 'successfully' do
    teacher = Instructor.create!(name: 'Nadya Ferris',
                                 bio: 'Self-taught Ruby on Rails teacher',
                                 email: 'ferrisn@coldmail.com')
    Course.create!(name: 'Ruby', 
                   description: 'Um curso de Ruby',
                   instructor: teacher, 
                   code: 'RUBYBASIC', 
                   price: 10,
                   enrollment_deadline: '22/12/2033'
                  )

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Editar'

    fill_in 'Nome', with: 'Basic Ruby'
    fill_in 'Descrição', with: 'Um curso básico de Ruby'
    fill_in 'Código', with: 'RUBY101'
    fill_in 'Preço', with: '15'
    fill_in 'Data limite de matrícula', with: '13/02/2022'
    click_on 'Salvar'

    expect(current_path).to eq(course_path(Course.last))
    expect(page).to_not have_content('Um curso de Ruby')
    expect(page).to_not have_content('RUBYBASIC')
    expect(page).to have_content('Basic Ruby')
    expect(page).to have_content('Um curso básico de Ruby')
    expect(page).to have_content('RUBY101')
    expect(page).to have_content('R$ 15,00')
    expect(page).to have_content('13/02/2022')
    expect(page).to have_link('Voltar')
  end

  scenario 'and must fill in name, code and price' do
    teacher = Instructor.create!(name: 'Nadya Ferris',
                                 bio: 'Self-taught Ruby on Rails teacher',
                                 email: 'ferrisn@coldmail.com')
    Course.create!(name: 'Ruby', 
                   description: 'Um curso de Ruby',
                   instructor: teacher, 
                   code: 'RUBYBASIC', 
                   price: 10,
                   enrollment_deadline: '22/12/2033'
                  )

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Preço', with: ''
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end
