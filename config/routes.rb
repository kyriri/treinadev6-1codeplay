Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  resources :courses, only: [:index, :show] # only limits the available routes
end