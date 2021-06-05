require 'rails_helper'

feature 'Student view courses on homepage' do
  scenario 'and view only courses still available' do
    teacher = Instructor.create!(name: 'Andy Carlos',
                                 bio: 'Um cara do contra: aprendeu C, depois Python, depois Ruby',
                                 email: 'andy_carlos@coldmail.com')
    available_course = Course.create!(name: 'Ruby', 
                                      description: 'Um curso de Ruby',
                                      instructor: teacher, 
                                      code: 'RUBYBASIC', 
                                      price: 10,
                                      enrollment_deadline: 1.month.from_now)
    unavailable_course = Course.create!(name: 'Alongamento', 
                                        description: 'Você e as senhorinhas simpáticas abrindo a academia',
                                        instructor: teacher, 
                                        code: 'STR101', 
                                        price: 110,
                                        enrollment_deadline: 1.day.ago)
    visit root_path
    expect(page).to have_content('Ruby')
    expect(page).to_not have_content('Alongamento')
  end

  scenario 'and view enrollment link' do
    test_user = User.create!(email: 'jane_doe@coldmail.com',
                             password: 'love-me_love-me',
                            )
    teacher = Instructor.create!(name: 'Andy Carlos',
                                 bio: 'Um cara do contra: aprendeu C, depois Python, depois Ruby',
                                 email: 'andy_carlos@coldmail.com')
    available_course = Course.create!(name: 'Ruby', 
                                      description: 'Um curso de Ruby',
                                      instructor: teacher, 
                                      code: 'RUBYBASIC', 
                                      price: 10,
                                      enrollment_deadline: 1.month.from_now)
    another_course = Course.create!(name: 'Alongamento', 
                                    description: 'Você e as senhorinhas simpáticas abrindo a academia',
                                    instructor: teacher, 
                                    code: 'STR101', 
                                    price: 110,
                                    enrollment_deadline: 1.day.ago)
    login_as test_user, scope: :user
    visit root_path
    click_on 'Ruby'
    click_on 'Comprar'

    expect(page).to have_content 'Curso comprado com sucesso'
    expect(current_path).to eq mine_courses_path
    expect(page).to have_content 'Ruby'
    expect(page).to_not have_content 'Alongamento'
  end

  scenario 'must be signed in to enroll' do
  end

  scenario 'and buy a course' do
    test_user = User.create!(email: 'jane_doe@coldmail.com',
                             password: 'love-me_love-me',
                            )
    teacher = Instructor.create!(name: 'Andy Carlos',
                                 bio: 'Um cara do contra: aprendeu C, depois Python, depois Ruby',
                                 email: 'andy_carlos@coldmail.com')
    available_course = Course.create!(name: 'Ruby', 
                                      description: 'Um curso de Ruby',
                                      instructor: teacher, 
                                      code: 'RUBYBASIC', 
                                      price: 10,
                                      enrollment_deadline: 1.month.from_now)
    login_as test_user, scope: :user

  end
end