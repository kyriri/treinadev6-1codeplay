require 'rails_helper'

describe 'Admin erases instructors' do
  it 'successfully' do
    Instructor.create!(name: 'Linda McCarthy', 
                       email: 'mccarthy@aol.com',
                       bio: 'Software engineer at Google', 
                      )
    Instructor.create!(name: 'Andy Carlos', 
                       email: 'andy@earth.com',
                       bio: 'Passionate of stretching, former Cirque du Soleil performer', 
                      )                         

    visit root_path
    click_on 'Professores'
    click_on 'Linda McCarthy'
    click_on 'Apagar registro'

    expect(current_path).to eq(instructors_path)
    expect(page).to_not have_content('Linda McCarthy')
    expect(page).to_not have_content('mccarthy@aol.com')
    expect(page).to_not have_content('Software engineer at Google')
    expect(page).to have_content('Andy Carlos')
  end

# TODO create test to simulate deletion error
end