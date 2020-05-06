Rails.application.routes.draw do

  get 'register', to: 'residents#new'
  get 'residents/index'
  get 'residents/:id', to: 'residents#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
