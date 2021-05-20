require 'rails_helper'

describe 'Admin erases courses' do
  it 'successfully' do
    Course.create!(name: 'Ruby Maravilha', 
                   description: 'Um curso feliz de Ruby',
                   code: 'RUBYBASIC', 
                   price: 10,
                   enrollment_deadline: '22/12/2033'
                  )                       
    Course.create!(name: 'Ruby Profundo', 
                   description: 'Um curso que te leva até as profundezas do Ruby',
                   code: 'RUBYDEEP', 
                   price: 35,
                   enrollment_deadline: '18/05/2021'
                  )  

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby Maravilha'
    
    
    # expect(page).to_have text('Curso apagado com successo') 
    expect { click_on 'Apagar curso' }.to change { Course.count }.by(-1)
    expect(current_path).to eq(courses_path)
    expect(page).to_not have_content('Ruby Maravilha')
    expect(page).to_not have_content('Um curso feliz de Ruby')
    expect(page).to_not have_content('RUBYBASIC')
    expect(page).to have_content('Ruby Profundo')

  end

# TODO create test to simulate deletion error
end