Rails.application.routes.draw do

  get 'register', to: 'residents#new'
  get 'residents/index'

  get 'residents/:floor/:unit/edit', to: 'residents#edit'
  patch 'residents/:floor/:unit/edit', to: 'residents#update'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
