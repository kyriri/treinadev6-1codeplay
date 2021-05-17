Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  resources :courses, only: [:index, :show, :new, :create] # "only" limits the available routes
  resources :instructors, only: [:index, :show, :new, :create] 
end