require 'rails_helper'

describe 'Admin registers instructors' do
  it 'from index page' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_link('Registrar um Professor',
                              href: new_instructor_path)
  end

  it 'successfully' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'

    fill_in 'Nome', with: 'Nadya Slobodowska'
    fill_in 'Descrição', with: 'Especialista back-end Ruby on Rails'
    fill_in 'Email', with: 'nadya.s@fmail.com'
    attach_file 'Foto de perfil', Rails.root.join('spec', 'fixtures', 'nadya.png')
    click_on 'Cadastrar professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_content('Nadya Slobodowska')
    expect(page).to have_content('Especialista back-end Ruby on Rails')
    expect(page).to have_content('nadya.s@fmail.com')
    expect(page).to have_css('img[src*="nadya.png"]')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    Instructor.create!(
                  name: 'Linda McCarthy', 
                  email: 'mccarthy@aol.com',
                  bio: 'Software engineer at Google', 
                  )

    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    click_on 'Cadastrar professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    Instructor.create!(
                  name: 'Andy Carlos', 
                  email: 'andy@earth.com',
                  bio: 'Passionate of stretching, former Cirque du Soleil performer', 
                  )

    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'
    fill_in 'Email', with: 'andy@earth.com'
    click_on 'Cadastrar professor'

    expect(page).to have_content('já cadastrado em outro registro')
  end
end