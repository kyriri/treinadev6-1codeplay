require 'rails_helper'

# video: 1:48:22

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
  end
end