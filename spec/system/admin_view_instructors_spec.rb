require 'rails_helper'

describe 'Admin view instructors' do
  it 'successfully' do
    Instructor.create!(
                  name: 'Andy Carlos', 
                  email: 'andy@earth.com',
                  bio: 'Passionate of stretching, former Cirque du Soleil performer', 
                  profile_picture: 'https://mypicture.com/me.jpg',
                  )
    Instructor.create!(
                  name: 'Linda McCarthy', 
                  email: 'mccarthy@aol.com',
                  bio: 'Software engineer at Google', 
                  profile_picture: 'https://www.random.com/me.png',
                  )

    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Andy Carlos')
    expect(page).to have_content('https://www.random.com/me.png')
  end

  it 'and view details' do
    Instructor.create!(
                      name: 'Andy Carlos', 
                      email: 'andy@earth.com',
                      bio: 'Passionate of stretching, former Cirque du Soleil performer', 
                      profile_picture: 'https://mypicture.com/me.jpg',
                      )
    Instructor.create!(
                      name: 'Linda McCarthy', 
                      email: 'mccarthy@aol.com',
                      bio: 'Software engineer at Google', 
                      profile_picture: 'https://www.random.com/me.png',
                      )

    visit root_path
    click_on 'Professores'
    click_on 'Linda McCarthy'

    expect(page).to have_content('Linda McCarthy')
    expect(page).to have_content('mccarthy@aol.com')
    expect(page).to have_content('Software engineer at Google')
    expect(page).to have_content('https://www.random.com/me.png')
  end

  it 'and no instructor is listed' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor cadastrado')
  end

  it 'and return to home page' do
    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'visit a profile and return to list' do
    Instructor.create!(
                      name: 'Andy Carlos', 
                      email: 'andy@earth.com',
                      bio: 'Passionate of stretching, former Cirque du Soleil performer', 
                      profile_picture: 'https://mypicture.com/me.jpg',
                      )

    visit root_path
    click_on 'Professores'
    click_on 'Andy Carlos'
    click_on 'Voltar'

    expect(current_path).to eq instructors_path
  end
end