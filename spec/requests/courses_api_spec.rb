require 'rails_helper'

describe 'Courses API' do
  context 'GET /api/v1/courses' do
    it 'should return courses' do
      teacher = Instructor.create!(name: 'Nadya Ferris',
                                    bio: 'Self-taught Ruby on Rails teacher',
                                    email: 'ferrisn@coldmail.com')
      Course.create!(name: 'Ruby Maravilha', 
                    description: 'Um curso feliz de Ruby',
                    instructor: teacher, 
                    code: 'RUBYBASIC', 
                    price: 10,
                    enrollment_deadline: 1.day.from_now
                    )                       
      Course.create!(name: 'Ruby Profundo', 
                    description: 'Um curso que te leva até as profundezas do Ruby',
                    instructor: teacher, 
                    code: 'RUBYDEEP', 
                    price: 35,
                    enrollment_deadline: 2.years.from_now
                    )  
      get '/api/v1/courses'
      # get api_v1_courses_path

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      
      expect(response.body).to include('Ruby Maravilha')
      expect(parsed_body[1]['name']).to eq('Ruby Profundo')
      expect(parsed_body.count).to eq(Course.count)

      expect(parsed_body[0]).to_not have_key('id')
      expect(parsed_body[0]).to_not have_key('created_at')
      expect(parsed_body[0]).to_not have_key('updated_at')
      expect(parsed_body[0]['instructor']).to_not have_key('id')
      expect(parsed_body[0]['instructor']).to_not have_key('created_at')
      expect(parsed_body[0]['instructor']).to_not have_key('updated_at')
      expect(parsed_body[0]['instructor']).to have_key('name')
      expect(parsed_body[0]['instructor']).to have_key('bio')
    end

    it 'returns no courses' do
      get '/api/v1/courses'
      
      expect(response.status).to eq(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to be_empty
    end

    it 'returns only courses with enrollment date in the future' do
      teacher = Instructor.create!(name: 'Nadya Ferris',
                                   bio: 'Self-taught Ruby on Rails teacher',
                                   email: 'ferrisn@coldmail.com')
      Course.create!(name: 'Ruby Maravilha', 
                    description: 'Um curso feliz de Ruby',
                    instructor: teacher, 
                    code: 'RUBYBASIC', 
                    price: 10,
                    enrollment_deadline: 1.month.from_now
                    )                       
      Course.create!(name: 'Ruby Profundo', 
                    description: 'Um curso que te leva até as profundezas do Ruby',
                    instructor: teacher, 
                    code: 'RUBYDEEP', 
                    price: 35,
                    enrollment_deadline: 1.day.ago
                    )  
      get '/api/v1/courses'

      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(1)
    end
  end

  context 'GET /api/v1/courses/:code' do
    it 'returns a course' do
      teacher = Instructor.create!(name: 'Nadya Ferris',
                                   bio: 'Self-taught Ruby on Rails teacher',
                                   email: 'ferrisn@coldmail.com')
      Course.create!(name: 'Ruby Maravilha', 
                    description: 'Um curso feliz de Ruby',
                    instructor: teacher, 
                    code: 'RUBYBASIC', 
                    price: 10,
                    enrollment_deadline: 1.day.from_now
                    )   
      course = Course.create!(name: 'Ruby Profundo', 
                              description: 'Um curso que te leva até as profundezas do Ruby',
                              instructor: teacher, 
                              code: 'RUBYDEEP', 
                              price: 35,
                              enrollment_deadline: 2.years.from_now
                              ) 
      # get '/api/v1/courses/RUBYDEEP'
      get "/api/v1/courses/#{course.code}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      
      expect(response.body).to include('RUBYDEEP')
      expect(response.body).to_not include('RUBYBASIC')
        
      expect(parsed_body.count).to eq(1)
      expect(parsed_body[0]['name']).to eq('Ruby Profundo')
      expect(parsed_body[0]).to_not have_key('id')
      expect(parsed_body[0]).to_not have_key('created_at')
      expect(parsed_body[0]).to_not have_key('updated_at')
      expect(parsed_body[0]['instructor']).to_not have_key('id')
    end

    it 'can\'t find course' do
      get '/api/v1/courses/RUBYSHALLOW'
      expect(response).to have_http_status(404)
    end
  end

  context 'POST /api/v1/courses' do
    it 'should create a course' do
      teacher = Instructor.create!(name: 'Nadya Ferris',
                                  bio: 'Self-taught Ruby on Rails teacher',
                                  email: 'ferrisn@coldmail.com')
  
      post '/api/v1/courses', params: {course: {
                                        name: 'Baking awesome cupcakes',
                                        code: 'CUP101',
                                        price: 51,
                                        instructor_id: teacher.id
                                      } }
  
      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      
      expect(parsed_body['name']).to eq('Baking awesome cupcakes')
      expect(parsed_body['code']).to eq('CUP101')
      expect(parsed_body['price'].to_f).to eq(51)
      expect(parsed_body['id']).to_not be_nil
      expect(parsed_body['instructor_id']).to_not be_nil
    end

    it 'fails to create a course due to lacking fields' do
      post '/api/v1/courses', params: {course: {
                                        name: 'Baking awesome cupcakes',
                                        code: 'CUP101',
                                        price: 51,
                                      } }
        expect(response).to have_http_status(406)
    end
  end
end

context 'PATCH /api/v1/courses/:code' do # or PUT?
  it 'succesfully' do
  end

  it 'has invalid fields' do
  end  
end

context 'DELETE /api/v1/courses/:code' do
  it 'succesfully' do
    teacher = Instructor.create!(name: 'Nadya Ferris',
                                  bio: 'Self-taught Ruby on Rails teacher',
                                  email: 'ferrisn@coldmail.com'
                                )
    one_course = Course.create!(name: 'Ruby Maravilha', 
                                description: 'Um curso feliz de Ruby',
                                instructor: teacher, 
                                code: 'RUBYBASIC', 
                                price: 10,
                                enrollment_deadline: 1.day.from_now
                                )                       
    another_course = Course.create!(name: 'Ruby Profundo', 
                                    description: 'Um curso que te leva até as profundezas do Ruby',
                                    instructor: teacher, 
                                    code: 'RUBYDEEP', 
                                    price: 35,
                                    enrollment_deadline: 2.years.ago
                                    )  
    delete "/api/v1/courses/#{another_course.code}"

    expect(response).to have_http_status(204)
    # expect(response.body).to include('Succesfully deleted')
    expect(one_course).to_not be_nil
    expect(Course.find_by(id: another_course.id)).to be_nil
  end

  it 'can\'t find entity to delete' do
    delete "/api/v1/courses/BARISTA"

    expect(response).to have_http_status(400)
  end
end

def parsed_body
  JSON.parse(response.body)
end