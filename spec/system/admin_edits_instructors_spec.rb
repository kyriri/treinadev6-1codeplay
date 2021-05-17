require 'rails_helper'

describe 'Admin updates instructor' do
  it 'successfully' do
    Instructor.create!(name: 'Andy Carlos', 
                       email: 'andy@earth.com',
                       bio: 'Passionate of stretching, former Cirque du Soleil performer', 
                       profile_picture: 'https://mypicture.com/me.jpg',
                      )
    visit root_path
    click_on 'Professores'
    click_on 'Andy Carlos'
    click_on 'Editar'

    fill_in 'Nome', with: 'Anderson Carlos'
    fill_in 'Descrição', with: 'Retired acrobatics instructor'
    fill_in 'Email', with: 'acarlos@coldmail.com'
    fill_in 'Foto de perfil', with: 'Empty'
    click_on 'Enviar'

    expect(page).to have_content('Anderson Carlos')
    expect(page).to have_content('Retired acrobatics instructor')
    expect(page).to have_content('acarlos@coldmail.com')
    expect(page).to have_content('Empty')
  end

  scenario 'and must fill name and email' do
    Instructor.create!(name: 'Andy Carlos', 
                       email: 'andy@earth.com',
                       bio: 'Passionate of stretching, former Cirque du Soleil performer', 
                       profile_picture: 'https://mypicture.com/me.jpg',
                      )
    visit root_path
    click_on 'Professores'
    click_on 'Andy Carlos'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end
end
