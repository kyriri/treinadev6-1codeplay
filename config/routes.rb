Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root "home#index"

  devise_for :users
  # resources :users, only %i[show]

  resources :instructors 
  resources :courses do
    resources :lessons
    post 'enroll', on: :member
    get 'mine', on: :collection
  end
  
  # get '/api/v1/courses', to: 'courses#index_api'
  namespace :api do
    namespace :v1 do
      resources :courses, only: %i[index show], param: :code
    end
  end
end