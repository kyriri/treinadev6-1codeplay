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

    fill_in 'Nome', with: 'Carla Maria'
    fill_in 'Descrição', with: 'Especialista back-end Ruby on Rails'
    fill_in 'Email', with: 'c.maria@ggmail.com'
    fill_in 'Foto de perfil', with: 'https://www.mypic.com.br/maria.jpg'
    click_on 'Cadastrar professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_content('Carla Maria')
    expect(page).to have_content('Especialista back-end Ruby on Rails')
    expect(page).to have_content('c.maria@ggmail.com')
    expect(page).to have_content('https://www.mypic.com.br/maria.jpg')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    Instructor.create!(
                  name: 'Linda McCarthy', 
                  email: 'mccarthy@aol.com',
                  bio: 'Software engineer at Google', 
                  profile_picture: 'https://www.random.com/me.png',
                  )

    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Foto de perfil', with: ''
    click_on 'Cadastrar professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    Instructor.create!(
                  name: 'Andy Carlos', 
                  email: 'andy@earth.com',
                  bio: 'Passionate of stretching, former Cirque du Soleil performer', 
                  profile_picture: 'https://mypicture.com/me.jpg',
                  )

    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'
    fill_in 'Email', with: 'andy@earth.com'
    click_on 'Cadastrar professor'

    expect(page).to have_content('já cadastrado em outro registro')
  end
end